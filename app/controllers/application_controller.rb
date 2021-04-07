class ApplicationController < ActionController::Base
  using ApplicationHelper
  before_action :initialize_session
  helper_method :cart

  def initialize_session
    # shoping cart will be an array of product id's and their quantities
    # if it's the first time a brower is at our site make it an empty array
    session[:shopping_cart] ||= [] # ||= means if nill then assign, otherwize not.
  end

  def cart
    # find will take one or a array and return a collections when passed and array.
    ApplicationHelper::Cart.new(session[:shopping_cart])
  end
end
