class Content < ApplicationRecord

    has_many :artwork_contents
    has_many :artworks, through: :artwork_contents

    require "google/cloud/vision"

    def self.google_cloud_vision(file, id)
        image_annotator = Google::Cloud::Vision::ImageAnnotator.new(credentials: JSON.parse(ENV.fetch("GOOGLE_APPLICATION_CREDENTIALS")))
        response = image_annotator.label_detection image: file
        response.responses.each do |res|
            res.label_annotations.each do |label| 
                content = self.find_or_create_by(description: label.description.downcase)
                ArtworkContent.create(content_id: content.id, artwork_id: id, score: label.score, confidence: label.confidence, topicality: label.topicality)
            end
        end
    end

end
#ArtworkContent.create(content_object: label.description, artwork_id: id)