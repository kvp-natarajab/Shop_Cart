class BrandsController < ApplicationController
	# load_and_authorize_resource
	before_filter :authenticate_user!
	layout :choose_layout

	before_action :set_brands, only: [:show, :edit, :update, :destroy]

	def index
		@brand = Brand.all
	end

	def new
		@brand = Brand.new
	end

	def show
	end

	def edit
	end


	def create
		@brand = Brand.new(brand_paramas)

		respond_to do |format|
			if @brand.save 
				format.html { redirect_to @brand, notice: "New brand added Successfully."}
				format.json { render :show, status: :created, location: @brand }
			else
				format.html { render :new }
				format.html { render json: @brand.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @brand.update(brand_paramas)
				format.html { redirect_to @brand, notice: "Brand Details Successfully Updated." }
				format.json { render :show, status: :ok, location: @brand }
			else
				format.html { render :edit }
				format.html { render json: @brand.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@brand.destroy
		respond_to do |format|
			format.html { redirect_to brands_path, notice: "Brand Deatails deleted." }
			format.json { head :no_content }
		end
	end



	private

	def set_brands
		@brand = Brand.find(params[:id])
	end

	def brand_paramas
		params.require(:brand).permit(:name, :description, :subcategory_id)
	end
end
