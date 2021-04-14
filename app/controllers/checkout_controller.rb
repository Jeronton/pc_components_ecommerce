class CheckoutController < ApplicationController
  def shipping; end

  def payment; end

  def apply_shipping
    # puts inputs.inspect
    inputs = params[:customer]
    province = if inputs[:customer_province_id].nil?
                 nil
               else
                 Province.find(inputs[:customer_province_id])
               end
    cust = Customer.find_or_create_by(
      first_name:    inputs[:first_name],
      middle_name:   inputs[:middle_name],
      last_name:     inputs[:last_name],
      address_line1: inputs[:address_line1],
      address_line2: inputs[:address_line2],
      country:       inputs[:country],
      province:      province,
      city:          inputs[:city],
      postal:        inputs[:postal],
      email:         inputs[:email],
      phone:         inputs[:phone]
    )

    if cust.valid?
      # set the current customer to this customr
      session[:customer_id] = cust.id

      redirect_to checkout_payment_path

    else
      redirect_to request.referer
    end
  end
end
