class StudentsController < ApplicationController
	# def index
	# 	@students = Student.order(:section_id).page params[:page]

	# end
	def index
		@filterrific = initialize_filterrific(
			Student,
			params[:filterrific],
			:select_options => {
        sorted_by: Student.options_for_sorted_by,
        with_section_id: Section.options_for_select
      }
			) or return
		@students = @filterrific.find.page(params[:page])

		respond_to do |format|
			format.html
			format.js
		end
	end

	def show
		@student = Student.find(params[:id])
	end

end

