ActiveAdmin.register Product do
  permit_params :name, :description, :price, :category_id, :image_small, :image_med, :image_large
  # , orders: %i[customer_id total status PST GST HST _destroy]

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    # f.has_many :orders do |n_f|
    #   n_f.input :orders
    # end
    f.inputs do
      f.input :image_small, as:   :file,
                            hint: f.object.image_small.present? ? image_tag(f.object.image_small) : ""
      f.input :image_med, as:   :file,
                          hint: f.object.image_med.present? ? image_tag(f.object.image_med) : ""
      f.input :image_large, as:   :file,
                            hint: f.object.image_large.present? ? image_tag(f.object.image_large) : ""
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
