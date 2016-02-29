class OrdersController < ApplicationController

	def new
		id=current_user.id
		

		@order = Order.new(user_id: id, order_date: Time.now)

		respond_to do |format|
			if @order.save 
				order = Order.select(:id).where(user_id:id).last
				order_number = current_customer.order_number_gen(order.id)
				@order.update_attribute(:ordernumber, order_number)
				format.html { redirect_to orders_show_path, notice: "New order Placed Successfully." }
			else
				format.html { redirect_to orders_show_path, notice: "Your order is not placed. Please try after some time." }
			end
		end
	end


end
