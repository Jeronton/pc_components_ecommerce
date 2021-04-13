class AddCustomerToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :customer, :reference
  end
end
