class OrderDetailsController < ApplicationController
	layout :choose_layout
	def index
		@orderdetails=OrderDetail.all
	end
end
