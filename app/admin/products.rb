ActiveAdmin.register Product do
  permit_params :name, :description, :price, :category_id
  # , orders: %i[customer_id total status PST GST HST _destroy]

  # form do |f|
  #   f.semantic_errors # shows errors on :base
  #   f.inputs          # builds an input field for every attribute
  #   f.has_many :orders do |n_f|
  #     n_f.input :orders
  #   end
  #   # f.inputs do
  #   #   f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image) : ""
  #   # end
  #   f.actions         # adds the 'Submit' and 'Cancel' buttons
  # end
end
