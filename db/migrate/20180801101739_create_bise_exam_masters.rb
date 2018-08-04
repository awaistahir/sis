class CreateBiseExamMasters < ActiveRecord::Migration[5.0]
  def change
    create_table :bise_exam_masters do |t|
    	t.belongs_to :student, index: true
    	t.string  :remarks
    	t.date    :date
    	t.integer :roll_no 
      t.timestamps
    end
  end
end
