class Product < ActiveRecord::Base
 	belongs_to :category
  belongs_to :subcategory
  belongs_to :brand
  belongs_to :user
  belongs_to :shipper
  
  has_many :order_details, :dependent => :destroy
  has_many :orders, :through => :order_details

  validates :product_name, :description, :unit_price, :total_unit, presence: true
  validates :total_unit, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_in_stock, numericality: { only_integer: true }
  # validates :avatar, format: { with: %r{\.(gif|jpg|png|jpeg)$}i }
  validate  :unit_in_stock_cannot_be_greater_than_total_unit

  def unit_in_stock_cannot_be_greater_than_total_unit
  	if unit_in_stock.to_i > total_unit.to_i
  		errors.add(:unit_in_stock, "can't be greater than total unit")
  	end
  end

  has_attached_file :avatar, styles: { medium: "600x600", small: "300x300>", thumb: "150x150>" }, default_url: "/images/:style/default.png"
  validates_attachment_content_type :avatar, { content_type: ["image/jpeg", "image/gif", "image/png", "image/png"] }
  validates :avatar, attachment_presence: true
  validates_with AttachmentPresenceValidator, attributes: :avatar
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 1.megabytes
end
