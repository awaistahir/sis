class SectionsController < ApplicationController

	def index
		@sections = Section.where(is_current: 1)
	end

	def show
		@section = Section.find(params[:id])
		@periods = @section.periods.order(:period_no)
		@students = @section.students
	end

	def result
		@section = Section.find(params[:id])
		@students = @section.students
	end

end