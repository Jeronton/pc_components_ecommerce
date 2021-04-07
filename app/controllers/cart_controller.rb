class CartController < ApplicationController
  def create
    # take in a params[:id] and that prodoct id to the session shopping cart
    logger.debug("adding #{params[:quantity]} #{params[:id]} to the shopping cart")
    id = params[:id].to_i
    quantity = params[:quantity].to_i
    product = Product.find(id)
    # ensure that the id passed is valid.
    if product && product.valid?
      session[:shopping_cart][id.to_s] = quantity
      puts "\n\n***************************************************************************************
      \n\nID is: #{id}\n QUANTITY IS: #{quantity} \nCART IS: #{session[:shopping_cart].inspect}\n\n\n
      *************************************************************************\n\n"
      flash[:notice] = "✔ Added #{product.name} to the cart"
    else
      flash[:notice] = "❌ Error adding item to the cart"
    end
    redirect_to products_path
  end

  def destroy
    # take in a params[:id] and remove that prodooct id to the session shopping cart
    logger.debug("removing #{params[:id]} from the shopping cart")
    id = params[:id].to_i
    quantity = params[:quantity].to_i
    product = Product.find(id)
    # ensure that the id passed is valid.
    if product && product.valid?
      session[:shopping_cart].delete(id.to_s) # removes the id from the array
      flash[:notice] = "✔ Removed #{product.name} from cart"
    else
      flash[:notice] = "❌ Error removing item from cart"
    end
    redirect_to products_path
  end

  def show; end
end
