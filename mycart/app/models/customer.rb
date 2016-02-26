class Customer < ActiveRecord::Base

		has_many :orders
	
	validates :name, :email, :address, :pincode, :password, :phone, presence: true
	validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/, message: "is not valid" }
	validates :address, length: { maximum: 200 }
	validates :phone, uniqueness: true, format: { with: /((0091)|(\+91)|0?)[789]{1}\d{9}/, message: "is not valid" }
	validates :land_mark, length: { minimum: 5 }, allow_blank: true
	validates :pincode, length: { minimum: 6 } 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
