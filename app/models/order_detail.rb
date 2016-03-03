class OrderDetail < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }, presence: true
  validates :discount, length: { minimum: 0, maximum: 100 }

  def subtotal(quantity,discount,price)
  	((quantity*price)-(quantity * (price * (discount/100)))).round
  end
end
