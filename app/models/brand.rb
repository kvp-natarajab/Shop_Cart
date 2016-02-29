class Brand < ActiveRecord::Base
   belongs_to :subcategory
  has_many :products, :dependent => :destroy
  
  validates :name, :description, presence: true
end
