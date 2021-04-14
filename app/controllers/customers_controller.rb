class CustomersController < ApplicationController
  def new
    if user_signed_in?
      unless current_user.customer.nil?
        # customer details have allready been associated with this account
        redirct_to root_path
      end
    else
      # user is not signed in so redirect to sign in page.
      redirect_to new_user_session_path
    end
  end

  def create
    # a
  end

  def show; end
end
