class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :description
      t.decimal :unit_price, precision: 5, scale: 2
      t.integer :total_unit
      t.integer :unit_in_stock
      t.integer :discount, length: { minimum:0, maximum: 100 }
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.references :subcategory, index: true, foreign_key: true
      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
