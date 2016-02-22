class Category < ActiveRecord::Base
	has_many :products
	has_many :subcategories
	validates :name, :description, presence:true
	validates :name, length: { minimum: 3 }
end
