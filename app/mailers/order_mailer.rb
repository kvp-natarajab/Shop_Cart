class OrderMailer < ApplicationMailer
	default from: "ordershopcart@gmail.com"

	def send_email(user,order)
		@user = user
		@order = order 
		@url = 'http://www.shoppingcart.com'
		mail(to: @user.email, subject: 'You order is placed successfully')
	end
end
