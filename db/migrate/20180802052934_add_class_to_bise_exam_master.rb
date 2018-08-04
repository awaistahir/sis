class AddClassToBiseExamMaster < ActiveRecord::Migration[5.0]
  def change
    add_column :bise_exam_masters, :student_class, :string
  end
end
