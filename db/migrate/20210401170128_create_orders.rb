class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :total
      t.string :status
      t.integer :PST
      t.integer :GST
      t.integer :HST

      t.timestamps
    end
  end
end
