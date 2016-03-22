class Shipper < ActiveRecord::Base
	has_many :products, :dependent => :destroy
	validates :company_name, :phone, presence: true
	validates :phone, uniqueness: true, format: { with: /((0091)|(\+91)|0?)[789]{1}\d{9}/, message: "is not valid" } 
end
