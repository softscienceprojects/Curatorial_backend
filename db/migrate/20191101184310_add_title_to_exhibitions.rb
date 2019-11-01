class AddTitleToExhibitions < ActiveRecord::Migration[6.0]
  def change
    add_column :exhibitions, :title, :string
  end
end
