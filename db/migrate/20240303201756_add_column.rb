class AddColumn < ActiveRecord::Migration[7.1]
  def change
    add_column :eventlistings, :views, :integer
  end
end
