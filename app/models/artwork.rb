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

    def self.test_hyperclient
        api = Hyperclient.new('https://grape-with-roar.herokuapp.com/api')
        puts api
    end

    def self.call_artsy(artsy_artwork_id)
        artwork_ins = Artwork.new
        api = Hyperclient.new('https://api.artsy.net/api') do |api|
            api.headers['Accept'] = 'application/vnd.artsy-v2+json'
            api.headers['X-Xapp-Token'] = ENV["ARTSY_TOKEN"]
            api.connection(default: false) do |conn|
              conn.use FaradayMiddleware::FollowRedirects
              conn.use Faraday::Response::RaiseError
              conn.request :json
              conn.response :json, content_type: /\bjson$/
              conn.adapter :net_http
            end
        end
        #andy_warhol = api.artist(id: 'andy-warhol')
        record = api.artwork(id: artsy_artwork_id)
        artwork_ins["origin_id"] = artsy_id
        artwork_ins["title"] = record["title"].to_s
        artwork_ins["medium"] = record["medium"].to_s
        artwork_ins["description"] = record["exhibition_history"].to_s
        artwork_ins["collection"] = record["collecting_institution"].to_s
        artwork_ins["location"] = record["provenance"].to_s
        artwork_ins["image_copyright"] = record["image_rights"].to_s
        artwork_ins["permalink"] = record["_links"]["permalink"].to_s

        ### t.string "image_url"
        image_url
        
        get_artist = record["_links"]["artists"]
        artist_id = get_artist.to_s.split("=")
        artist = api.artist(id: artist_id)
        artwork_ins["artist"] = artist["name"]
        
        #puts "#{andy_warhol.name} was born in #{andy_warhol.birthday} in #{andy_warhol.hometown}"
        # return ...
    end


    def self.get_artsy_images(artsy_id)
        artwork = Artwork.new # ************
        artwork.call_artsy(slug)

        ##
        #artwork["image_url"] = record["_links"]["image"]["href"] 
          ## saves with {image_version}
        #artwork["artist"] = record["_links"]["artists"]["href"]
         ## need to get ID off the end and do another call
         ## "artists": {
         ##    "href": "https://api.artsy.net/api/artists?artwork_id=4d8b92ee4eb68a1b2c0009ab"
         ##    }
         ## then
         ## artist["_embedded"]["artists"][0]["name"]
        artwork.save!
        # Content.google_cloud_vision(artwork.image_url, artwork.id)
        sleep 5
        # record["_links"]["next"]["href"]
    end
     

end
