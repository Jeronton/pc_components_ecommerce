ActiveAdmin.register Customer do
  permit_params :province_id, :phone, :email, :country, :city, :address_line1, :address_line2, :postal, :first_name, :middle_name, :last_name
end
