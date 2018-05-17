class Course < ApplicationRecord
	enum grade: {"6th" => 7}
	has_many :questions
	
end
