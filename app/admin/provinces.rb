ActiveAdmin.register Province do
  permit_params :abbreviation, :name, :PST, :pst_tax_id, :GST, :gst_tax_id, :HST, :hst_tax_id

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    # f.has_many :orders do |n_f|
    #   n_f.input :orders
    # end
    f.inputs do
      f.input :gst_tax_id
      f.input :pst_tax_id
      f.input :hst_tax_id
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
