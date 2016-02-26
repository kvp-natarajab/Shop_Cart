class Subcategory < ActiveRecord::Base
  belongs_to :category
  has_many :products
  has_many :brands
  
  validates	:name, :description, presence: true
  validates :name, length: { minimum: 3 }
end
