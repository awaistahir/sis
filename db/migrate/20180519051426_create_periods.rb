class CreatePeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :periods do |t|
    	t.belongs_to :teacher, index: true
      t.belongs_to :section, index: true
      t.belongs_to :course, index: true
      t.integer    :period_no
      t.boolean    :incharge, default: false

      t.timestamps
    end
  end
end
