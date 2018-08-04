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
		puts "5%%%%%%%%%%%%%%%%%"
		puts @student

		puts "5%%%%%%%%%%%%%%%%%"
		@result10 = @student.result(10)
		@result10_details = @result10.bise_exam_details unless @result10.blank?
	end


end

