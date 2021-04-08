class OrdersController < ApplicationController
  def index; end

  def show; end

  def create
    @items = cart_items
    @customer = Customer.find(session[:customer_id])

    # where the total/taxes will be stored
    subtotal = 0
    pst = 0
    gst = 0
    hst = 0

    if @customer.valid?
      order = Order.create(
        customer: @customer,
        total:    0,
        status:   "incomplete",
        PST:      pst,
        GST:      gst,
        HST:      hst
      )

      # add products to the order and calculate taxes
      @items.each do |item|
        product = item[:product]
        quantity = item[:quantity]
        OrderProduct.create(
          order:    order,
          product:  product,
          price:    product.price,
          quantity: quantity
        )

        # Add to total and taxes.
        subtotal += product.price
        pst += product.price * quantity * @customer.province.PST unless @customer.province.PST.nil?
        gst += product.price * quantity * @customer.province.GST unless @customer.province.GST.nil?
        hst += product.price * quantity * @customer.province.HST unless @customer.province.HST.nil?
      end

      # calculate the full total
      total = subtotal + pst + gst + hst

      # Update the order with the calculated totals
      order.update(
        total:  total,
        status: "pending",
        PST:    pst,
        GST:    gst,
        HST:    hst
      )
    end
  end
end
