class ChangeColumnInProducts < ActiveRecord::Migration
  def change
  	change_column(:products, :unit_price, :decimal, precision: 12, scale: 2)
  	change_column(:orders, :freight, :decimal, precision: 12, scale: 2)
  end
end
