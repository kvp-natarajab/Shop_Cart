class CategoriesController < ApplicationController
	# load_and_authorize_resource
	before_filter :authenticate_user!

	layout :choose_layout
	before_action :set_category, only: [:show, :edit, :update, :destroy]

	def index
		@category = Category.all
	end

	def show
	end

	def new
		@category = Category.new
	end

	def edit
	end


	def create
		@category = Category.new(category_paramas)

		respond_to do |format|
			if @category.save
				format.html { redirect_to @category, notice: "Category was successfully created." }
				format.json { render :show, status: :created, location: @category }
			else
				format.html { render :new }
				format.json { render json: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @category.update(category_paramas)
				format.html { redirect_to @category, notice: "Category details updated." }
				format.json { render :show, status: :ok, location: @category }
			else
				format.html { render :edit }
				formta.json { render json: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@category.destroy
		respond_to do |format|
			format.html { redirect_to categories_path, notice: "Category details Deleted."}
			format.json { head :no_content }
		end
	end

	private

	def set_category
		@category = Category.find(params[:id])
	end

	def category_paramas
		params.require(:category).permit(:name, :description)
	end
end
