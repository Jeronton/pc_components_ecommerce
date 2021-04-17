class ApplicationController < ActionController::Base
  using ApplicationHelper
  before_action :initialize_session
  helper_method :cart
  helper_method :categories

  def initialize_session
    # shoping cart will be an array of product id's and their quantities
    # if it's the first time a brower is at our site make it an empty array
    session[:shopping_cart] ||= {} # ||= means if nill then assign, otherwize not.
  end

  def clear_cart
    session[:shopping_cart] = {}
  end

  # returns all the categories
  def categories
    Category.all
  end

  def cart
    session[:shopping_cart]
  end

  # Gets the items from the session cart formated as an array of
  # hashes with product: the product, quantity: the quantity of products.
  def cart_items
    cart_items = []
    cart.each do |id, quantity|
      cart_items << { product:  Product.find(id),
                      quantity: quantity }
    end
    cart_items
  end

  # Gets the products from the session cart formated as an array of products
  def cart_products
    cart_products = []
    cart.each do |id, quantity|
      cart_products << Product.find(id)
    end
    cart_products
  end

  # Ovverride where redirected to after sign in.
  def after_sign_in_path_for(user)
    new_customer_path
  end
end
