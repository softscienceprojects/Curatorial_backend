class CreateArtworkContents < ActiveRecord::Migration[6.0]
  def change
    create_table :artwork_contents do |t|
      t.references :content, null: false, foreign_key: true
      t.references :artwork, null: false, foreign_key: true
      t.float :score
      t.float :confidence
      t.float :topicality

      t.timestamps
    end
  end
end
