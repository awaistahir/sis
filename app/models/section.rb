class Section < ApplicationRecord
	has_many :periods
  has_many :teachers, through: :periods

	has_many :students
	enum name: {iqbal: 0, jinnah: 1, ghazali: 2, fatima: 3}
	enum grade: {"katchi" => 1, "1" => 2, "2" => 3, "3" => 4, "4" => 5, "5" => 6,  "6" => 7, "7" => 8, "8" => 9, "9" =>10, "10" => 11 }

	def self.options_for_select
    order('LOWER(name)').map { |e| [e.grade  + "  " + e.name   , e.id] }
  end

end
