class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
    	t.integer  :name
    	t.integer  :grade
    	t.date    :year
    	# t.references :collaborator, index: true, foreign_key: true


      t.timestamps
    end
  end
end