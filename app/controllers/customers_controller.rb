class CustomersController < ApplicationController
  def new
    if user_signed_in?
      unless current_user.customer.nil?
        # customer details have allready been associated with this account
        redirect_to root_path
      end
    else
      # user is not signed in so redirect to sign in page.
      redirect_to new_user_session_path
    end
  end

  def create
    if user_signed_in?
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
        # associate this user with the provided customer details
        user = User.find(current_user.id)
        user.update(customer: cust)

        flash[:notice] = "✔ Successfully saved shipping information."
        redirect_to root_path
      else
        puts cust.errors.inspect
        redirect_to request.referer
      end
    else
      redirect_to new_user_session_path
    end
  end

  def show; end
end
