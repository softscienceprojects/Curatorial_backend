class Artwork < ApplicationRecord

    has_many :artwork_exhibitions
    has_many :exhibitions, through: :artwork_exhibitions

    has_many :artwork_contents
    has_many :contents, through: :artwork_contents

    def self.get_harvard_images
        #pages 23361 / 10 records per query
        ##LAST QUERY RAN:
        page = 16
        while page < 20
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
        page +=1
        end
    end
        
end
