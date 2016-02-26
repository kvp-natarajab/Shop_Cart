class CatalogController < ApplicationController
	def index
		if params[:product_name]
			values = params[:product_name].split(" ")
			@products = Product.where('product_name LIKE ?', "#{values.first.downcase}%")
		elsif params[:id]
			@category = Category.find(params[:id])
			@products = Product.where(:category_id => @category.id)
		end
			
	end
end
