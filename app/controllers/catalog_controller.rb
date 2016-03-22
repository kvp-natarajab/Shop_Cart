class CatalogController < ApplicationController
	def index
		if params[:search_text]
			values = params[:search_text].split(" ")
			@products = Product.where('lower(product_name) LIKE ?', "#{values.first.downcase}%").where(:active=>true)
		elsif params[:id]
			@category = Category.find(params[:id])
			@products = Product.where(:category_id => @category.id, :active => true)
		elsif params[:category_id]
			@products = Product.where(:category_id => params[:category_id], :active => true)
		elsif params[:sub_cat_id]
			@products = Product.where(:subcategory_id => params[:sub_cat_id].to_i, :active => true)
			@brands = Brand.select(:name,:id).where(subcategory_id: params[:id])
		end	
	end


end
