class ArtworkExhibition < ActiveRecord::Migration[6.0]
  def change
    create_table :artwork_exhibitions do |t|
      t.references :exhibition
      t.references :artwork
    end
  end
end
