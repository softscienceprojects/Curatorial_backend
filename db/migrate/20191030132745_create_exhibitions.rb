class CreateExhibitions < ActiveRecord::Migration[6.0]
  def change
    create_table :exhibitions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :summary
      t.text :description
      t.boolean :public

      t.timestamps
    end
  end
end
