class CreateBiseExamDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :bise_exam_details do |t|
    	t.belongs_to :bise_exam_master, index: true
    	t.string   :subject
    	t.integer   :max_marks
    	t.integer   :part1
    	t.integer   :part2
    	t.integer   :practical
    	t.string    :total_remarks
      t.timestamps
    end
  end
end
