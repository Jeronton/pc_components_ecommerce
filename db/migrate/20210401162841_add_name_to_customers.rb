class AddNameToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :first_name, :string
    add_column :customers, :middle_name, :string
    add_column :customers, :last_name, :string
  end
end
