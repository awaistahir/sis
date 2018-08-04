class ChangeDataTypeForPart1Part2 < ActiveRecord::Migration[5.0]
  def change
  	change_column :bise_exam_details, :part1, :string
  	change_column :bise_exam_details, :part2, :string

  end
end
