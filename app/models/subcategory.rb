class Subcategory < ActiveRecord::Base
	
  belongs_to :category
  has_many :products, :dependent => :destroy
  has_many :brands, :dependent => :destroy
  
  validates	:name, :description, presence: true
  validates :name, length: { minimum: 3 }
end
