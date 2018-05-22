class TeachersController < ApplicationController
	
	def index
		# @teachers = Teacher.all
		@filterrific = initialize_filterrific(
			Teacher,
			params[:filterrific],
			:select_options => {
        sorted_by: Teacher.options_for_sorted_by,
        with_section_id: Teacher.options_for_select
      }
			) or return
		@teachers = @filterrific.find.page(params[:page]).per(100)

		respond_to do |format|
			format.html
			format.js
		end
	end

	def show
    @teacher = Teacher.find(params[:id])
  end

end
