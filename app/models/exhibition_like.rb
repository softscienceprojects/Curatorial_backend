class ExhibitionLike < ApplicationRecord
  belongs_to :user
  belongs_to :exhibition
end
