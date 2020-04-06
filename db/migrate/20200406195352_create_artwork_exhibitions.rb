class CreateArtworkExhibitions < ActiveRecord::Migration[6.0]
  def change
    create_table :artwork_exhibitions do |t|
      t.references :artwork, null: false, foreign_key: true
      t.references :exhibition, null: false, foreign_key: true
    end
  end
end
