class AddCompanyToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :company, :string
    add_column :users, :subscription_type, :string
  end
end
