class Brand < ActiveRecord::Base
   belongs_to :subcategory
  has_many :products
  
  validates :name, :description, presence: true
end
