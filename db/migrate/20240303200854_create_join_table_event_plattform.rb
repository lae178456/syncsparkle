class CreateJoinTableEventPlattform < ActiveRecord::Migration[7.1]
  def change
    create_join_table :events, :plattforms do |t|
      # t.index [:event_id, :plattform_id]
      # t.index [:plattform_id, :event_id]
    end
  end
end
