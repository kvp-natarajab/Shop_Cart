class Order < ActiveRecord::Base
   belongs_to :customer
  belongs_to :shipper
  has_many :order_details
  has_many :products, :through => :order_details
  
  validates :order_date, :order_number, presence: true
  validate :shipped__date_cannot_be_in_the_past

  def shipped__date_cannot_be_in_the_past
  	if shipped_date.present? && shipped_date < Date.today
  		errors.add(:shipped_date, "can't be in the past")
  	end
  end
end
