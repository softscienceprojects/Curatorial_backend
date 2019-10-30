class Content < ApplicationRecord

    has_many :artwork_contents
    has_many :artworks, through: :artwork_contents


    def self.make_content(label, id, score, confidence, topicality)
        content = Content.find_or_create_by(description: label)
        ArtworkContent.create(content_id: content.id, artwork_id: id, score: score, confidence: confidence, topicality: topicality )
    end


    require "google/cloud/vision"

    def self.google_cloud_vision(file, id)
        image_annotator = Google::Cloud::Vision::ImageAnnotator.new(credentials: JSON.parse(ENV.fetch("GOOGLE_APPLICATION_CREDENTIALS")))
        response = image_annotator.label_detection image: file
        response.responses.each do |res|
            res.label_annotations.each { |label| Content.make_content(label.description.downcase, id, label.score, label.confidence, label.topicality)}
        end
    end


    

end