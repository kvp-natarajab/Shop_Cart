module CatalogHelper
	def subategory_list(params)
		@subcategories=Subcategory.where(category_id: params[:id]) 
		@subcategories.each do |subcategory|
			link_to subcategory.name, catalog_index_path(:sub_cat_id => subcategory.id)
		end 
	end
end
