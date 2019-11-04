class ExhibitionLikeSerializer < ActiveModel::Serializer
  attributes :id, :exhibition, :exhibition_id, :user_id #, :exhibitions
  # include: [ :exhibition ]

  # def exhibitions
  #   object.exhibitions.map do |exhibition|
  #     ExhibitionSerializer.new(exhibition)
  #   end
  # end

end
