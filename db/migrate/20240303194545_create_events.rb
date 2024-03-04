class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :location
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.string :hashtags
      t.boolean :online_event
      t.string :url
      t.string :categories
      t.integer :user_id
      t.string :image

      t.timestamps
    end
  end
end
