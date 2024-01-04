class HolidaysController < ApplicationController
  def index
		@holidays = Holiday.all.order(created_at: :desc).paginate(page: params[:page], per_page: 2)
	end

	def new
		@holiday = Holiday.new
	end
	
	def create
		@holiday = Holiday.new(holiday_params)
		if @holiday.save
			redirect_to holidays_path
			flash[:notice] = "Leave Created Successfully."
		else
			render 'new'
		end
	end
	

	def edit
		@holiday = Holiday.find(params[:id])
		respond_to do |format|
			format.js
			format.html
		end
	end

	def update
		@holiday = Holiday.find(params[:id])
		if @holiday.update(holiday_params)
			redirect_to holidays_path
			flash[:notice] = "Leave Updated Successfully."
		else
			render 'edit'
		end
	end

	def destroy
		@holiday = Holiday.find(params[:id])
		@holiday.destroy
		redirect_to holidays_path
		flash[:notice] = "Leave Deleted Successfully."
	end

	private
		def holiday_params
			params.require(:holiday).permit(:name, :no_of_holidays)
		end
end
