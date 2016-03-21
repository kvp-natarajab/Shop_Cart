class User < ActiveRecord::Base

  belongs_to :role
  has_many :orders, :dependent => :destroy
  has_many :products, :dependent => :destroy

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable


  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user
    if user.nil?
      email = auth.info.email if auth.info.email.present?
      user = User.where(:email => email).first if email
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user = user.assign_role if user.role.nil?
        user.save!
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def assign_role
      self.role = Role.find_by name: "Customer"
      self
  end
  
  def admin?
    unless self.role.nil?
        self.role.name == "Admin"
      else
        self.assign_role
      end
  end

  def seller?
    unless self.role.nil?
        self.role.name == "Seller"
      end
  end
    
  def customer?
    unless self.role.nil?
        self.role.name == "Customer"
    end
  end

  

	# validates :name, :email, :address, :pincode, :password, :phone, presence: true
	# validates :email, uniqueness: true # format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/,
	# validates :address, length: { maximum: 200 }
	# validates :phone, uniqueness: true, format: { with: /((0091)|(\+91)|0?)[789]{1}\d{9}/, message: "is not valid" }
	# validates :landmark, length: { minimum: 5 }, allow_blank: true
	# validates :pincode, length: { minimum: 6 } 


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
  

	def seller_list
    	User.where(:role_id => role_id).map{|u| [u.id,u.name]}
  end
 
end
