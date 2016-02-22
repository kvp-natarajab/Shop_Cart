class CreateShippers < ActiveRecord::Migration
  def change
    create_table :shippers do |t|
      t.string :company_name, limit: 80
      t.string :phone, limit: 14
      t.integer :no_of_day
      
      t.timestamps null: false
    end
  end
end
