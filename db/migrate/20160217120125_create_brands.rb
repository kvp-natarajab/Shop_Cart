class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :brand_name, limit: 100
      t.text :description
      t.references :subcategory, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
