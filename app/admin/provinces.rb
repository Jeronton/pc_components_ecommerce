ActiveAdmin.register Province do

  permit_params :abbreviation, :name, :PST, :GST, :HST

end
