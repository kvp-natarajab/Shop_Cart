class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :description
      t.decimal :unit_price, precision: 12, scale: 2
      t.integer :total_unit
      t.attachment :avatar
      t.integer :unit_in_stock
      t.decimal :freight, precision: 12, scale: 2
      t.integer :discount, length: { minimum:0, maximum: 100 }
      t.boolean :active
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.references :subcategory, index: true, foreign_key: true
      t.references :brand, index: true, foreign_key: true
      t.references :shipper, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
