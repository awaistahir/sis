class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
    	t.string  :name
			t.string  :father_name
			t.date    :dob
			t.string  :father_cnic
			t.string  :mobile
      t.references :section, foreign_key: true

      t.timestamps
    end
  end
end


