class CreateTeachers < ActiveRecord::Migration[5.0]
	def change
		create_table :teachers do |t|
			t.string  :name
			t.string  :father_name
			t.string  :designation
			t.integer :bps
			t.string  :qualification
			t.date    :dob
			t.date    :date_of_appointment
			t.date    :date_of_present_grade 	
			t.date    :date_of_joining_school 	
			t.string  :cnic 	
			t.text    :address
			t.string  :mobile
			t.integer :school, default: 0 	

			t.timestamps
		end
	end
end
