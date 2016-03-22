class ProductsController < ApplicationController
	# load_and_authorize_resource
	skip_before_filter :verify_authenticity_token, :only => [:create, :edit]
	before_filter :authenticate_user!
	before_action :set_product, only: [:show, :edit, :update, :destroy]

	layout :choose_layout

	def index

		if current_user.seller?
			@product = Product.where(user_id:current_user.id).order(created_at: :asc)
		else
		 	@product = Product.all.order(created_at: :asc)
		end
	end

	def new
		@product = Product.new
	end

	def edit
	end

	def create
		@product = Product.new(product_paramas)
		@product.user_id = current_user.id
		respond_to do |format|
			if @product.save
				format.html { redirect_to @product, notice: "Product was successfully created." }
				format.json { render :show, status: :created, location: @product }
			else
				format.html { render :new }
				format.json { render json: @product.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @product.update(product_paramas)
				format.html { redirect_to @product, notice:"Product details successfully updated." }
				format.json { render :show, status: :ok,location: @product }
			else
				format { render :edit }
				format.json { render json: @product.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@product.destroy
    	respond_to do |format|
      		format.html { redirect_to products_path, notice: 'Product was successfully destroyed.' }
      		format.json { head :no_content }
    	end
	end

	def subcat
		@subcategories = Subcategory.select(:name,:id).where(category_id: params[:id])
		render json: @subcategories
	end

	def brand
		@brands = Brand.select(:name,:id).where(subcategory_id: params[:id])
		render json: @brands
	end

	

	def search
		@products = Product.select(:product_name).where('lower(product_name) LIKE ?', "#{params[:search_text].downcase}%")
		render json: @products.map(&:product_name)	
	end
	

	private

	def set_product
		@product = Product.find(params[:id])
	end

	def product_paramas
		params.require(:product).permit(:product_name, :description, :unit_price, :total_unit, :unit_in_stock, :discount, :user_id, :category_id, :subcategory_id, :brand_id, :avatar, :shipper_id, :active, :freight)
	end

end
