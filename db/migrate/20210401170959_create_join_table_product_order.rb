class CreateJoinTableProductOrder < ActiveRecord::Migration[6.1]
  def change
    create_join_table :products, :orders do |t|
      # t.index [:product_id, :order_id]
      # t.index [:order_id, :product_id]
      t.integer :price
      t.integer :quantity
    end
  end
end
