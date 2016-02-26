class CartsController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    cart_ids = $redis.smembers current_customer_cart
    @cart_products = Product.find(cart_ids)
  end

  def add
  	$redis.sadd current_customer_cart, params[:product_id]
    redirect_to cart_path
  end

  def remove
  	$redis.srem current_customer_cart, params[:product_id]
    redirect_to cart_path
  end

  private

  def current_customer_cart
  	"cart#{current_customer.id}"
  end
end
