class Section < ApplicationRecord
	has_many :periods
  has_many :teachers, through: :periods

	has_many :students
	enum name: {Iqbal: 0, Jinnah: 1, Ghazali: 2}
	enum grade: {"Katchi" => 1, "1st" => 2, "2nd" => 3, "3rd" => 4, "4th" => 5, "5th" => 6,  "6th" => 7, "7th" => 8, "8th" => 9, "9th" =>10, "10th" => 11 }

	def self.options_for_select
    order('LOWER(name)').map { |e| [e.grade  + "  " + e.name   , e.id] }
  end

end
