class AddTaxIdsToProvinces < ActiveRecord::Migration[6.1]
  def change
    add_column :provinces, :pst_tax_id, :string
    add_column :provinces, :gst_tax_id, :string
    add_column :provinces, :hst_tax_id, :string
  end
end
