class CheckoutController < ApplicationController
  def create
    # establish a connection with Stripe!

    # at min 23 of second vid

    # redirect the user back to a payment screen

    productItems = []
    cart_items.each do |item|
      product = item[:product]
      productItems << {
        name:        product.name,
        description: product.description,
        amount:      product.price,
        currency:    "cad",
        quantity:    item[:quantity]
      }
    end

    if productItems.size == 0
      flash[:notice] = "❌ No items in cart to purchase."
      redirect_to request.referer
      return
    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url,
      line_items:           productItems
    )

    # @session.id <== is autopopulated from this process!

    respond_to do |format|
      format.js # render app/views/checkout/create.js.erb
    end
  end

  def success
    # WE TOOK YO MONEY!

    # stripe success_url +"?session_id={CHECKOUT_SESSION_ID}"

    @session = Stripe::Checkout::Session.retrieve(params[:session_id])

    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
    # Something went wrong
  end

  def shipping
    @customer = user_signed_in? ? current_user.customer : Customer
  end

  def payment; end

  def apply_shipping
    # puts inputs.inspect
    inputs = params[:customer]
    province = if inputs[:province_id].nil?
                 nil
               else
                 Province.find(inputs[:province_id])
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
      puts cust.errors.inspect
      redirect_to request.referer
    end
  end
end
