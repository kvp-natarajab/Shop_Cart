class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :ordernumber
      t.datetime :order_date
      t.datetime :shipped_date
      t.decimal :freight, precision: 5, scale: 2
      t.references :customer, index: true, foreign_key: true
      t.references :shipper, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
