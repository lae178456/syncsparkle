class CreatePlattforms < ActiveRecord::Migration[7.1]
  def change
    create_table :plattforms do |t|
      t.string :url
      t.string :plattform

      t.timestamps
    end
  end
end
