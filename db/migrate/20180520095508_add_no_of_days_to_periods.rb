class AddNoOfDaysToPeriods < ActiveRecord::Migration[5.0]
  def change
    add_column :periods, :no_of_days, :string
  end
end
