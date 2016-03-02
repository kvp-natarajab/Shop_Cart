class ShippersController < ApplicationController
	layout :choose_layout
	before_action :set_shipper, only: [:show, :edit, :upadte, :destroy]

	def index
		@shipper = Shipper.all
	end

	def show
	end

	def new
		@shipper = Shipper.new
	end

	def create
		@shipper = Shipper.new(shipper_params)
		respond_to do |format|
			if @shipper.save
				format.html { redirect_to @shipper, notice: "New Shipper Details successfully created." }
				format.json { render :show, status: :created, location: @shipper }
			else
				format.html { render :new }
				format.json { render json: @shipper.errors, status: :unprocessable_entity }
			end
		end
	end

	def edit
	end
	
	def destroy
		@shipper.destroy
		respond_to do |format|
			format.html { redirect_to shipper_path, notice: "Shipper Details successfully deleted." }
			format.json { head :no_content }
		end
	end


	def update
		respond_to do |format|
			if @shipper.update(shipper_params)
				format.html { redirect_to @shipper, notice: "Shipper details successfully upadted." }
				format.json { render :show, status: :ok, location: @shipper }
			else
				format.html { render :edit }
				format.html { render json: @shipper.errors, status: :unprocessable_entity }
			end
		end
	end

	private

	def shipper_params
		params.require(:shipper).permit(:company_name, :no_of_day, :phone)
	end

	def set_shipper
		@shipper = Shipper.find(paramas[:id])
	end
end
