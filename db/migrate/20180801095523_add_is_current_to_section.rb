class AddIsCurrentToSection < ActiveRecord::Migration[5.0]
  def change
    add_column :sections, :is_current, :boolean, default: 1
  end
end
