class CheckoutController < ApplicationController
  def shipping; end

  def payment; end

  def apply_shipping
    # puts params.inspect
    cust = Customer.find_or_create_by(
      first_name:    params[:first_name],
      middle_name:   params[:middle_name],
      last_name:     params[:last_name],
      address_line1: params[:address_line1],
      address_line2: params[:address_line2],
      country:       params[:country],
      province:      Province.find(params[:province_id]),
      city:          params[:city],
      postal:        params[:postal],
      email:         params[:email],
      phone:         params[:phone]
    )

    if cust.valid?
      # set the current customer to this customr
      session[:customer_id] = cust.id

      redirect_to checkout_payment_path
    end
  end
end
