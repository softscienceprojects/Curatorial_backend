class CreateArtworks < ActiveRecord::Migration[6.0]
  def change
    create_table :artworks do |t|
      t.string :artist
      t.string :title
      t.string :medium
      t.text :description
      t.string :collection
      t.string :location
      t.string :image_url
      t.string :image_copyright
      t.string :permalink
      t.string :origin_id

      t.timestamps
    end
  end
end
