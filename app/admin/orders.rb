ActiveAdmin.register Order do
  permit_params :customer, :total, :status, :PST, :GST, :HST, order_products: %i[price quantity],
                                                              products:       %i[name description category_id]

  form do |f|
    f.semantic_errors # shows errors on :base
    # f.inputs          # builds an input field for every attribute
    f.inputs
    f.has_many :order_products do |o_f|
      # # o_f.has_one :products do |p_f|
      # f.input products: :name
      # # end
      o_f.input :price
      o_f.input :quantity
    end
    # f.inputs do
    #   f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image) : ""
    # end
    f.actions # adds the 'Submit' and 'Cancel' buttons
  end

  # form do |f|
  #   f.semantic_errors # shows errors on :base
  #   # f.inputs          # builds an input field for every attribute
  #   f.inputs do
  #     f.input :customer_id
  #     f.input :total
  #     f.input :status
  #     f.input :PST
  #     f.input :GST
  #     f.input :HST
  #     f.has_many :products do |n_f|
  #       n_f.input :name
  #     end
  #   end
end
