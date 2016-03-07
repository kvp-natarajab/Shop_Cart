class ApplicationController < ActionController::Base
  autocomplete :product, :product_name
  before_filter :ensure_signup_complete, only: [:new, :create, :update, :destroy]
  before_action :configure_permitted_parameters, if: :devise_controller?
  include CanCan::ControllerAdditions

 
  rescue_from CanCan::AccessDenied do |exception|
      flash[:error] = "Access denied!"
      redirect_to root_url
  end
  
  def ensure_signup_complete
    return if action_name == 'finish_signup'
    
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  protect_from_forgery with: :exception
  protected

	def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name,:role_id, :email, :password,:phone, :address, :landmark, :city, :state, :country, :pincode ]
    devise_parameter_sanitizer.for(:account_update) << [:name, :role_id, :email, :password, :phone, :address, :landmark, :city, :state, :country, :pincode ]
  end

  # def assign_role
  #   self.role = Role.find_by name: "Customer" if self.role.nil?
  # end

  def current_user_cart
    "cart#{current_user.id}"
  end

  def choose_layout
    if current_user.admin?
      "admin"
    elsif current_user.seller?
      "seller"
    else
      "application"
    end
  end
  
end
