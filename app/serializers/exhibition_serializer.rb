class ExhibitionSerializer < ActiveModel::Serializer
  attributes :id, :summary, :description, :public
  has_one :user
end
