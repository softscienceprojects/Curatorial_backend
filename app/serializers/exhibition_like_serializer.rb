class ExhibitionLikeSerializer < ActiveModel::Serializer
  attributes :id, :exhibition_id, :user_id #, :exhibitions
  belongs_to :exhibition

  def exhibitions
    object.exhibitions.map do |exhibition|
      ExhibitionSerializer.new(exhibition)
    end
  end

end
