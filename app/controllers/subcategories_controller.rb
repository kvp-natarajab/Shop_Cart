class SubcategoriesController < ApplicationController
	before_action :set_subcategory, only: [:show, :edit, :update, :destroy]

	def index
		@subcategory = Subcategory.all
	end

	def show
	end
		
	def new
		@subcategory = Subcategory.new
	end

	def edit
	end

	def create
		@subcategory = Subcategory.new(subcategory_params)
		respond_to do |format|
			if @subcategory.save
				format.html { redirect_to @subcategory, notice: "Subcategory details created." }
				format.json { render :show, status: :created, location: @subcategory }
			else
				format.html { render :new }
				format.json { render json: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @subcategory.update(subcategory_params)
				format.html { redirect_to subcategory_path, notice: "Subcategory successfully details updated." }
				format.json { render :show, status: :ok, location: @subcategory }
			else
				format.html { render :edit }
				formta.json { render json: @subcategory.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@subcategory.destroy
		respond_to do |format|
			format.html { redirect_to subcategories_path, notice: "Subcategory successfully details deleted." }
			format.json { head :no_content }
		end
	end

	private

	def set_subcategory
		@subcategory = Subcategory.find(params[:id])
	end

	def subcategory_params
		params.require(:subcategory).permit(:name, :description, :category_id)
	end
end
