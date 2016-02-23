class ApplicationController < ActionController::Base


  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |user_params|
    
    	if resource_class == Customer
    		user_params.permit(:name, :email, :phone, :password, :password_confirmation, :address, :land_mark, :city, :state, :country, :pincode, :remember_me)
    	elsif resource_class == Seller
    		user_params.permit(:company_name, :contact_person, :phone, :address, :password, :password_confirmation, :email, :city, :state, :country, :pincode, :status, :remember_me)
    	end
    end

    # devise_parameter_sanitizer.for(:sign_in) do |user_params|
    # 	if resource_class == Customer
    # 		user_params.permit(:login, :phone, :email, :password, :remember_me)
    # 	elsif resource_class == Seller
    # 		user_params.permit(:login, :phone, :email, :password, :remember_me)
    # 	end
    # end

    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }

   
    # devise_parameter_sanitizer.for(:account_update) do |user_params| 
    # 	if resource_class == Customer
    # 		user_params.permit(:name, :email, :phone, :password, :password_confirmation, :address, :land_mark, :city, :state, :country, :pincode, :current_password) 
    # 	elsif resource_class == Seller
    # 		user_params.permit(:company_name, :contact_person, :phone, :address, :password, :password_confirmation, :email, :city, :state, :country, :pincode, :status, :current_password) 
    # 	end		
    # end
  end

end
