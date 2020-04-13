class Artwork < ApplicationRecord

    has_many :artwork_exhibitions, dependent: :destroy
    has_many :exhibitions, through: :artwork_exhibitions

    has_many :artwork_contents, dependent: :destroy
    has_many :contents, through: :artwork_contents

    # has_one_attached :image_url

    def content_names
        self.contents.map{|c| c.description}
    end

    def save_image_url(artwork_id, artsy_image_url)
        # get image_url from artsy
        # save in bucket to s3
        # get return value of s3 image
        # save to db
        ## artwork = Artwork.find(artwork_id)
        ## artwork["image_url"] = "https://..."
    end

    def self.get_harvard_images(start_page, end_page)
        #pages 23361 / 10 records per query
        ##LAST QUERY RAN: page 800, page < 1000
        page = start_page
        while page < end_page
            response = RestClient.get "https://api.harvardartmuseums.org/object?apikey=#{ENV["HARVARD_KEY"]}&q=divison%3AModern%20and%20Contemporary%20Art&imagecount=1&page=#{page}"
            result = JSON.parse( response )
            # result["records"][0]
            result["records"].each do |record|
                if record["imagecount"] > 0 && record["images"] != nil && record["images"] != [] && record["people"] != nil
                    artwork = Artwork.new

                    artwork["medium"] = record["technique"]
                    artwork["artist"] = record["people"][0]["name"]
                    artwork["description"] = record["description"]
                    artwork["title"] = record["title"]
                    artwork["collection"] = record["creditline"]
                    artwork["location"] = "Harvard Art Museum"
                    artwork["image_url"] = "https://idscache.harvardartmuseums.org/ids/view/#{record["images"][0]["idsid"]}"
                    artwork["image_copyright"] = record["images"][0]["copyright"]
                    artwork["permalink"] = record["url"]
                    artwork["origin_id"] = record["id"]

                    artwork.save!
                    Content.google_cloud_vision(artwork.image_url, artwork.id)
                end
            end
        sleep 5
        page +=1
        end
    end   

    require "hyperclient"
    require "aws-sdk-s3"
    require "open-uri"

    def self.get_artsy_image(artsy_artwork_id)
        # artwork_ins = Artwork.new
        # api = Hyperclient.new('https://api.artsy.net/api') do |api|
        #     api.headers['Accept'] = 'application/vnd.artsy-v2+json'
        #     api.headers['X-Xapp-Token'] = ENV["ARTSY_TOKEN"]
        #     api.connection(default: false) do |conn|
        #       conn.use FaradayMiddleware::FollowRedirects
        #       conn.use Faraday::Response::RaiseError
        #       conn.request :json
        #       conn.response :json, content_type: /\bjson$/
        #       conn.adapter :net_http
        #     end
        # end
        
        # record = api.artwork(id: artsy_artwork_id)
        # artwork_ins["origin_id"] = artsy_id
        # artwork_ins["title"] = record["title"].to_s
        # artwork_ins["medium"] = record["medium"].to_s
        # artwork_ins["description"] = record["exhibition_history"].to_s
        # artwork_ins["collection"] = record["collecting_institution"].to_s
        # artwork_ins["location"] = record["provenance"].to_s
        # artwork_ins["image_copyright"] = record["image_rights"].to_s
        # artwork_ins["permalink"] = record["_links"]["permalink"].to_s

        # image_url = record["_links"]["image"].to_s.split(".jpg")
        # image_url[0] + "larger.jpg"
        
        s3 = Aws::S3::Client.new(
            region: ENV['AWS_REGION'],
            access_key_id: ENV['AWS_ACCESS_KEY_ID'],
            secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
        )
           
        ## resp = s3.list_buckets
        ##     resp.buckets.each do |b|
        ##         puts b.name
        ##     end

        image_test_url = "https://res.cloudinary.com/streethub/image/upload/w_690,f_auto,q_auto:eco,dpr_auto,c_pad,b_white/v1576063261/brand/5bdad3abba85830003b5b07c/r5zdoyepkp2pqm7umegh.jpg"
        s3.put_object({bucket: ENV["AWS_BUCKET"], body: open(image_test_url), key: "cacti.jpg"})

        ## artwork_ins["image_url"] = (artsy_artwork_id + ".jpg",open(image_url[0] + "larger.jpg")
        
        # Content.google_cloud_vision(artwork.image_url, artwork.id)
       
        #get_artist = record["_links"]["artists"]
        #artist_id = get_artist.to_s.split("=")
        #artist = api.artist(id: artist_id)
        # artwork_ins["artist"] = artist["name"]
        #puts artist["name"]
        
        # artwork_ins.save!
    end
     

end
