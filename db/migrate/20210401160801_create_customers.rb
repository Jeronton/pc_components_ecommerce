class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.references :province, null: false, foreign_key: true
      t.string :name
      t.string :phone
      t.string :email
      t.string :country
      t.string :city
      t.string :address_line1
      t.string :address_line2
      t.string :postal

      t.timestamps
    end
  end
end
