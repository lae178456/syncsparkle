class AddCardDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :card_name, :string
    add_column :users, :card_number, :integer
    add_column :users, :card_expiry, :date
    add_column :users, :card_cvc, :string
  end
end
