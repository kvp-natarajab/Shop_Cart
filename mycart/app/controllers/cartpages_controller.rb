class CartpagesController < ApplicationController
	def index
		@category = Category.find_by(:name => params[:search])
		@products = Product.where(:category_id => @category.id)
	end
end
