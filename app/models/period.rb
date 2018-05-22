class Period < ApplicationRecord
	enum period_no:{"1st" => 1, "2nd" => 2, "3rd" => 3, "4th" => 4, "5th" => 5,  "6th" => 6, "7th" => 7, "8th" => 8}

	belongs_to :teacher
  belongs_to :section
  belongs_to :course
end
