class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	# user.url = auth_hash['info']['urls'][user.provider.capitalize]
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	belongs_to :role
	has_many :orders, :dependent => :destroy
	has_many :products, :dependent => :destroy
	validates :name, :email, :address, :pincode, :password, :phone, presence: true
	validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/, message: "is not valid" }
	validates :address, length: { maximum: 200 }
	validates :phone, uniqueness: true, format: { with: /((0091)|(\+91)|0?)[789]{1}\d{9}/, message: "is not valid" }
	validates :land_mark, length: { minimum: 5 }, allow_blank: true
	validates :pincode, length: { minimum: 6 } 
  	def cart_count
  		$redis.scard "cart#{id}"
	end

	def order_number_gen(order_number)
  		"1%.5d" % order_number
	end

	def price_after_discount(unit_price,discount)
     	(unit_price-(unit_price * ((discount)/100))).round
  	end

	def user_id
		id
	end

	def admin?
	    self.role.name == "Admin"
	end

	def seller?
	    self.role.name == "Seller"
	end
	  
	def customer?
	    self.role.name == "Customer"
	end
  

	def seller_list
    	User.where(:role_id => role_id).map{|u| [u.id,u.name]}
  	end
 
end
