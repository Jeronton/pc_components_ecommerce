class AddCustomerRefToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :customer, null: true, foreign_key: true
  end
end
