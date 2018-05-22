class AddShortnameToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :shortname, :string
  end
end
