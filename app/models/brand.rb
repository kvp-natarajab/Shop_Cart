class Brand < ActiveRecord::Base
  belongs_to :subcategory
  has_many :products
  
  validates :brand_name, :description, presence: true
end
