class CheckoutController < ApplicationController
  def create
    # get the in progress orser
    order = Order.find(session[:order_id])

    orderedProducts = order.order_products
    puts "\n\n\n\n**************************\n\n\n"
    puts orderedProducts.inspect
    puts "\n\n***********\n\n"

    productItems = []
    orderedProducts.each do |item|
      product = item.product
      productItems << {
        name:        product.name,
        description: product.description,
        amount:      item.price,
        currency:    "cad",
        quantity:    item.quantity
      }
    end

    # redirect user back as no items to purchase
    if productItems.size == 0
      flash[:notice] = "❌ No items in cart to purchase."
      redirect_to request.referer
      return
    end

    # @session.id <== is autopopulated from this process!
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url,
      line_items:           productItems
    )

    respond_to do |format|
      format.js # render app/views/checkout/create.js.erb
    end
  end

  def success
    # Just display a trustful success page, it will asume that if navigated to it was indeed a success!
    # but the payment will be validated, and the order's status updated using stripes events.

    # but still update the order status so that we at least know that the user attempted to submit payment

    # @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    # @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

    # puts "\n\n\n******************************\n\n\n"
    # puts @payment_intent.charges.data[0].class
    # puts @payment_intent.charges.data[0].inspect

    # puts "\n\n\n******************************\n"
    # charge = @payment_intent.charges.data[0]

    # redirect to cancel if not paid
    # redirect_to checkout_cancel_path unless charge.paid
  end

  def cancel
    # Something went wrong
  end

  def shipping
    @customer = user_signed_in? ? current_user.customer : Customer
  end
end
