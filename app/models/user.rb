class User < ActiveRecord::Base
	
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
	  devise :database_authenticatable, :registerable, :confirmable,
	    :recoverable, :rememberable, :trackable, :validatable, :omniauthable

	  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

	  def self.find_for_oauth(auth, signed_in_resource = nil)

	    # Get the identity and user if they exist
	    identity = Identity.find_for_oauth(auth)

	    # If a signed_in_resource is provided it always overrides the existing user
	    # to prevent the identity being locked with accidentally created accounts.
	    # Note that this may leave zombie accounts (with no associated identity) which
	    # can be cleaned up at a later date.
	    user = signed_in_resource ? signed_in_resource : identity.user

	    # Create the user if needed
	    if user.nil?

	      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
	      email = auth.info.email if email_is_verified
	      user = User.where(:email => email).first if email

	      # Create the user if it's a new registration
	      if user.nil?
	        user = User.new(
	          name: auth.extra.raw_info.name,
	          #username: auth.info.nickname || auth.uid,
	          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
	          password: Devise.friendly_token[0,20]
	        )
	        user.skip_confirmation!
	        user.save!
	      end
	    end

	    # Associate the identity with the user if needed
	    if identity.user != user
	      identity.user = user
	      identity.save!
	    end
	    user
	  end

	  def email_verified?
	    self.email && self.email !~ TEMP_EMAIL_REGEX
	  end

	belongs_to :role
	has_many :orders, :dependent => :destroy
	has_many :products, :dependent => :destroy
	validates :name, :email, :address, :pincode, :password, :phone, presence: true
	validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/, message: "is not valid" }
	validates :address, length: { maximum: 200 }
	validates :phone, uniqueness: true, format: { with: /((0091)|(\+91)|0?)[789]{1}\d{9}/, message: "is not valid" }
	validates :landmark, length: { minimum: 5 }, allow_blank: true
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
