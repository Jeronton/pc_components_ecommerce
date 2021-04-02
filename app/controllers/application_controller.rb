class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :cart

  def initialize_session
    # shoping cart will be an array of product id's and their quantities
    # if it's the first time a brower is at our site make it an empty array
    session[:shopping_cart] ||= [] # ||= means if nill then assign, otherwize not.
  end

  def cart
    # find will take one or a array and return a collection when passed and array.
    Product.find(session[:shopping_cart])
  end
end
