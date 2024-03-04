class FixColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :plattforms, :plattform, :plattform_name
  end
end
