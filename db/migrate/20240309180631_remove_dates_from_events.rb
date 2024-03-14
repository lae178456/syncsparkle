class RemoveDatesFromEvents < ActiveRecord::Migration[7.1]
  def change
    remove_column :events, :start_date, :date
    remove_column :events, :end_date, :date
    remove_column :events, :start_time, :time
    remove_column :events, :end_time, :time
  end
end
