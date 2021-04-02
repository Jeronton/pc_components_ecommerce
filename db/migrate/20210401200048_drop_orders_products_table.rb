class DropOrdersProductsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :orders_products
  end
end
