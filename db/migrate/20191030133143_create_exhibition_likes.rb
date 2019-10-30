class CreateExhibitionLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :exhibition_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :exhibition, null: false, foreign_key: true
    end
  end
end
