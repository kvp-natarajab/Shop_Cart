class CartsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    cart_ids = $redis.smembers current_user_cart
    @cart_products = Product.find(cart_ids)
  end

  def add
  	$redis.sadd current_user_cart, params[:product_id]
    redirect_to cart_path
  end

  def remove
  	$redis.srem current_user_cart, params[:product_id]
    redirect_to cart_path
  end


  def unit
    product = Product.find(params[:product_id])
    render json: product
  end

  def status
    product = Product.find(params[:product])
    if params[:status]=="checked"
      product.update_attribute(:active, true)
      @msg = "Product is activated"
    else
      product.update_attribute(:active, false)
      @msg = "Product is De-activated"
    end
    render json:@msg
  end
end
