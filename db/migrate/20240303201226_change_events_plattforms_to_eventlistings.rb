class ChangeEventsPlattformsToEventlistings < ActiveRecord::Migration[7.1]
  def change
    rename_table :events_plattforms, :eventlistings
  end
end
