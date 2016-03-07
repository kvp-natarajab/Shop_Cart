class CatalogController < ApplicationController
	def index
		
		if params[:search_text]
			values = params[:search_text].split(" ")
			@products = Product.where('lower(product_name) LIKE ?', "#{values.first.downcase}%")
		elsif params[:id]
			@category = Category.find(params[:id])
			@products = Product.where(:category_id => @category.id)
		elsif params[:category_id]
			@products = Product.where(:category_id => params[:category_id])
		elsif params[:sub_cat_id]
			@products = Product.where(:subcategory_id => params[:sub_cat_id])
		end
			
	end
end
