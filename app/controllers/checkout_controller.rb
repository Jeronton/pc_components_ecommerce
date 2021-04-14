class CheckoutController < ApplicationController
  def create
    # establish a connection with Stripe!

    # redirect the user back to a payment screen

    product = Product.find(params[:product_id])

    if product.nil?

      redirect_to root_path

      return

    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url,
      line_items:           [

        {

          name:        product.name,
          description: product.description,
          amount:      product.price_cents,
          currency:    "cad",
          quantity:    1
        },

        {
          name:        "GST",
          description: "Goods and Services Tax",
          amount:      (product.price_cents * 0.05).to_i,
          currency:    "cad",
          quantity:    1
        }

      ]
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
