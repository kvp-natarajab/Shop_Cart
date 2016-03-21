class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :ordernumber
      t.datetime :order_date
      t.datetime :shipped_date
      t.references :user, index: true, foreign_key: true
      t.references :order_status, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
