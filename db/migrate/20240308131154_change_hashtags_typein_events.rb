class ChangeHashtagsTypeinEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :hashtags_tmp, :text, array: true, default: []

    Event.reset_column_information

    Event.find_each do |event|
      event.update(hashtags_tmp: [event.hashtags])
    end

    remove_column :events, :hashtags
    rename_column :events, :hashtags_tmp, :hashtags
  end
end
