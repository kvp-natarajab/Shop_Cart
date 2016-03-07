class OrderDetailsController < ApplicationController
	layout :choose_layout
	def index
		if current_user.seller?
			@orderdetails=Product.joins(:user).where(:user_id=>current_user.id).joins(:orders).joins(:order_details).select('products.*,orders.*,order_details.*,users.name').uniq
		else
			@orderdetails=Product.joins(:user).joins(:orders).joins(:order_details).select('products.*,orders.*,order_details.*,users.name').uniq
		end
	end

	def show
		@order = Order.find_by(:ordernumber=>params[:id])
		@user = User.find_by(id: @order.user_id)
		@orderdetails = OrderDetail.joins(:product).where(:order_number=>params[:id]).select('products.*,order_details.*')
		
		respond_to do |format|
      		format.html
      		format.pdf do
	        pdf = InvoicePdf.new(@orderdetails,@user,@order, view_context)
	        send_data pdf.render, filename: 
	        "invoice_#{params[:id]}.pdf",
	        type: "application/pdf", disposition: "inline"
      end
    end

	end
end
