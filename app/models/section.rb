class Section < ApplicationRecord

	has_many :students
	enum name: {Iqbal: 0, Jinnah: 1, Ghazali: 2}
	enum grade: {"6th" => 7}

end
