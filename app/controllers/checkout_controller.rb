class CheckoutController < ApplicationController
  # constants
  TYPE_GST = "GST".freeze
  TYPE_PST = "PST".freeze
  TYPE_HST = "HST".freeze

  def create
    # get the in progress order
    order = Order.find(session[:order_id])

    orderedProducts = order.order_products
    # puts "\n\n\n\n**************************\n\n\n"
    # puts orderedProducts.inspect
    # puts "\n\n***********\n\n"

    # get the tax rate(s)
    tax_ids = []
    province = order.customer.province

    # puts "\n\n\n**********************\n\n"
    # puts "nil: #{province.GST.nil?}"
    # puts "gst: #{province.GST.to_d}"
    # puts "0d: #{0.0.to_d}"
    # puts "is 0?: #{province.GST.to_d != 0.0.to_d}"
    # puts "province gst id: #{province.gst_tax_id}"
    if !province.GST.nil? && province.GST.to_d != 0.0.to_d
      gst_tax = nil
      # province has GST, so get its id, or make it if null
      if province.gst_tax_id.nil? || province.gst_tax_id == ""
        # has no tax created yet, so create
        gst_tax = createProvinceTax(province, TYPE_GST)
      else
        # retrieve the tax from stripe
        gst_tax = Stripe::TaxRate.retrieve(province.gst_tax_id)
        # puts "old gst id: #{gst_tax.id}"
        if gst_tax.nil?
          # the id is no longer valid, for example if manually delete from stripe dashboard
          gst_tax = createProvinceTax(province, TYPE_GST)
        elsif gst_tax.percentage.to_d != province.GST.to_d * 100
          # we changed the tax rate in our database (or in stripe), so update them to be the same.
          gst_tax = updateProvinceTax(province, TYPE_GST, gst_tax)
        end
      end

      # puts "new gst id: #{gst_tax.id}"
      # puts "new province gst id: #{province.gst_tax_id}"
      # finally add the tax id!
      tax_ids << gst_tax.id

      # puts "\n\n**********************\n\n"
    end

    # get any pst
    if !province.PST.nil? && province.PST.to_d != 0.0.to_d
      pst_tax = nil
      if province.pst_tax_id.nil? || province.pst_tax_id == ""
        # has no tax created yet, so create
        pst_tax = createProvinceTax(province, TYPE_PST)
      else
        # retrieve the tax from stripe
        pst_tax = Stripe::TaxRate.retrieve(province.pst_tax_id)
        if pst_tax.nil?
          # the id is no longer valid, for example if manually delete from stripe dashboard
          pst_tax = createProvinceTax(province, TYPE_PST)
        elsif pst_tax.percentage.to_d != province.PST.to_d * 100
          # we changed the tax rate in our database (or in stripe), so update them to be the same.
          pst_tax = updateProvinceTax(province, TYPE_PST, pst_tax)
        end
      end
      # finally add the tax id!
      tax_ids << pst_tax.id
    end

    # get any hst
    if !province.HST.nil? && province.HST.to_d != 0.0.to_d
      hst_tax = nil
      if province.hst_tax_id.nil? || province.hst_tax_id == ""
        # has no tax created yet, so create
        hst_tax = createProvinceTax(province, TYPE_HST)
      else
        # retrieve the tax from stripe
        hst_tax = Stripe::TaxRate.retrieve(province.hst_tax_id)
        if hst_tax.nil?
          # the id is no longer valid, for example if manually delete from stripe dashboard
          hst_tax = createProvinceTax(province, TYPE_HST)
        elsif hst_tax.percentage.to_d != province.HST.to_d * 100
          # we changed the tax rate in our database (or in stripe), so update them to be the same.
          hst_tax = updateProvinceTax(province, TYPE_HST, hst_tax)
        end
      end
      # finally add the tax id!
      tax_ids << hst_tax.id
    end

    # build the list items to send to stripe
    productItems = []
    orderedProducts.each do |item|
      product = item.product
      productItems << {
        name:        product.name,
        description: product.description,
        amount:      item.price,
        currency:    "cad",
        quantity:    item.quantity,
        tax_rates:   tax_ids
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

    # save the stripe session id
    order.update(stripe_session: @session.id)

    # send to stripe!
    respond_to do |format|
      format.js # render app/views/checkout/create.js.erb
    end
  end

  def success
    # Just display a trustful success page, it will asume that if navigated to it was indeed a success!
    # but the payment will be validated, and the order's status updated using stripes events.

    # but still update the order status so that we at least know that the user attempted to submit payment
    order = Order.find(session[:order_id])
    order.update(status: "unconfirmed_paid") if order.status == "unsubmitted"

    clear_cart

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

  def createProvinceTax(province, type)
    tax_rate = nil
    if type == TYPE_GST
      tax_rate = Stripe::TaxRate.create({
                                          display_name: "GST",
                                          inclusive:    false,
                                          percentage:   province.GST * 100,
                                          country:      "CA",
                                          state:        province.abbreviation
                                        })
      province.update(gst_tax_id: tax_rate.id)
    end
    if type == TYPE_PST
      tax_rate = Stripe::TaxRate.create({
                                          display_name: "PST",
                                          inclusive:    false,
                                          percentage:   province.PST * 100,
                                          country:      "CA",
                                          state:        province.abbreviation
                                        })
      province.update(pst_tax_id: tax_rate.id)
    end
    if type == TYPE_HST
      tax_rate = Stripe::TaxRate.create({
                                          display_name: "HST",
                                          inclusive:    false,
                                          percentage:   province.HST * 100,
                                          country:      "CA",
                                          state:        province.abbreviation
                                        })
      province.update(hst_tax_id: tax_rate.id)
    end
    tax_rate
  end

  def updateProvinceTax(province, type, oldTax)
    tax_rate = nil
    # deactivate the old tax as it is no longer used
    Stripe::TaxRate.update(
      oldTax.id,
      { active: false }
    )
    if type == TYPE_GST
      tax_rate = Stripe::TaxRate.create({
                                          display_name: "GST",
                                          inclusive:    false,
                                          percentage:   province.GST * 100,
                                          country:      "CA",
                                          state:        province.abbreviation
                                        })
      province.update(gst_tax_id: tax_rate.id)
    end
    if type == TYPE_PST
      tax_rate = Stripe::TaxRate.create({
                                          display_name: "PST",
                                          inclusive:    false,
                                          percentage:   province.PST * 100,
                                          country:      "CA",
                                          state:        province.abbreviation
                                        })
      province.update(pst_tax_id: tax_rate.id)
    end
    if type == TYPE_HST
      tax_rate = Stripe::TaxRate.create({
                                          display_name: "HST",
                                          inclusive:    false,
                                          percentage:   province.HST * 100,
                                          country:      "CA",
                                          state:        province.abbreviation
                                        })
      province.update(hst_tax_id: tax_rate.id)
    end
    tax_rate
  end
end
