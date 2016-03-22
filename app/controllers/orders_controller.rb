class OrdersController < ApplicationController

	def new
		id=current_user.id
		if  current_user.cart_count>0
			@user = User.find(current_user.id)
			@user.update_attributes(:name => params[:user_name], :address => params[:user_address], :phone => params[:user_phone], :pincode => params[:user_pincode])
			@order = Order.new(user_id: id, order_date: Time.now)
			respond_to do |format|
				if @order.save 
					update_order_value(id)
					send_mail_empty_cart
					format.html { redirect_to orders_show_path, notice: "New order Placed Successfully." }
				else
					format.html { redirect_to orders_show_path, notice: "Your order is not placed. Please try after some time." }
				end
			end
		else
			respond_to do |format|
				format.html { redirect_to orders_show_path, notice: "Cannot Place order cart is empty." }
			end
		end
	end


	def send_mail_empty_cart
		# OrderMailer.send_email(current_user, @order).deliver_now
		$redis.del current_user_cart
	end

	def update_order_value(id)
		order = Order.select(:id).where(user_id:id).last
		order_number = current_user.order_number_gen(order.id)
		@order.update_attribute(:ordernumber, order_number)
		get_oder_details_info(order_number,order.id)
	end

	def get_oder_details_info(order_number,order_id)
		product_count = current_user.cart_count
		i=0
		while i < product_count do
			product_id = get_product_info(i)
			product_quantity = get_product_quantity(i)
			update_product_table(product_id,product_quantity)
			save_order_details(order_number,order_id,product_id,product_quantity)
			i+=1
		end
	end

	def update_product_table(prd_id,prd_qnty)
		@product = Product.find(prd_id)
		@product.update_attribute(:unit_in_stock,prd_qnty)
	end

	def get_product_info(index)
		params[:product]["#{index}"]
	end

	def get_product_quantity(index)
		params[:quantity]["#{index}"]
	end


	def save_order_details(order_number,order_id,product_id,product_quantity)
		 product = Product.select(:discount, :user_id).find(product_id)
		 @order_detail = OrderDetail.new(order_number: order_number, quantity: product_quantity, discount: product.discount, order_id: order_id, product_id: product_id, user_id: product.user_id)
		 @order_detail.save
	end

	def show
		@order = Order.where(:user_id => current_user.id).last
		@order_detail = OrderDetail.where(:order_number=>@order.ordernumber)
	end

end
