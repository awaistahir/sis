class BiseExamMaster < ApplicationRecord

	belongs_to :student
	has_many   :bise_exam_details
end
