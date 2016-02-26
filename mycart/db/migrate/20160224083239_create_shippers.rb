class CreateShippers < ActiveRecord::Migration
  def change
    create_table :shippers do |t|
      t.string :compnay_name
      t.string :phone, limit: 14
      t.integer :day

      t.timestamps null: false
    end
  end
end
