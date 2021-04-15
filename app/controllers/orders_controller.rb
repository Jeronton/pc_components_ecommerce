class OrdersController < ApplicationController
  def index; end

  def show
    @order = Order.find(params[:id])
    if @order.customer.id == session[:customer_id]
      @orderProducts = @order.order_products
      @total = @order.total
      @pst = @order.PST
      @gst = @order.GST
      @hst = @order.HST
      @subtotal = @total - @pst - @gst - @hst
      @preOrder = @order.status == "unsubmitted"
    end
  end

  def create
    # get and save shipping details
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

      # valid customer data, so create order summary
      @items = cart_items
      @customer = Customer.find(cust.id) unless session[:customer_id].nil?

      if @items.nil? || @items.size == 0
        flash[:notice] = "❌ Must have at least one item to prepare order."
        redirect_to request.referer
        return
      elsif @customer.nil?
        flash[:notice] = "❌ Error fetching shipping details for order."
        redirect_to request.referer
        return
      end

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
          subtotal += product.price * quantity
          unless @customer.province.PST.nil?
            pst += product.price * quantity * @customer.province.PST
          end
          unless @customer.province.GST.nil?
            gst += product.price * quantity * @customer.province.GST
          end
          unless @customer.province.HST.nil?
            hst += product.price * quantity * @customer.province.HST
          end
        end

        # calculate the full total
        total = subtotal + pst + gst + hst

        # Update the order with the calculated totals
        order.update(
          total:  total,
          status: "unsubmitted",
          PST:    pst,
          GST:    gst,
          HST:    hst
        )

        redirect_to(order) if order.valid?
      end
    else
      # ivalid shipping details, will have to find way to display errors.
      puts cust.errors.inspect
      redirect_to request.referer
    end
  end
end
