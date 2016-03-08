class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :user_param, only: [:show, :edit, :update, :destroy]
  layout :choose_layout
 
  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def edit
  end


  def create
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    successfully_updated = if needs_password?(@user, user_params)
                             @user.update(user_params)
                           else
                             @user.update_without_password(user_params)
                           end

    respond_to do |format|
      if successfully_updated
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    def needs_password?(user, params)
      params[:password].present?
    end

   
    def user_params
      accessible = [ :name, :email, :password, :password_confirmation, :role_id, :landmark, :phone, :address, :city, :state, :country, :pincode ] 
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end
end
