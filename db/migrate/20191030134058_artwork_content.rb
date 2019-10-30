class ArtworkContent < ActiveRecord::Migration[6.0]
  def change
    create_table :artwork_contents do |t|
      t.references :content
      t.references :artwork
      t.float :score
      t.float :confidence
      t.float :topicality

      t.timestamps
  end
end
