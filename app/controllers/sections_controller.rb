class SectionsController < ApplicationController

	def index
		@sections = Section.all 
	end

	def show
		@section = Section.find(params[:id])
		@periods = @section.periods.order(:period_no)
		@students = @section.students
	end

end