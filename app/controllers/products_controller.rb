class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).all

    # if category is passed then filter by it.
    category_id = begin
      Integer(params[:category])
    rescue StandardError
      -1
    end
    @category = Category.find(Integer(params[:category])) unless category_id < 0
    @products = @products.where(category_id: params[:category]) unless category_id < 0

    # if search paramerter exists, search by it
    search_string = "%#{params['search'].downcase}%"
    unless params["search"].nil? || params["search"] == ""
      @products = @products.where(
        "LOWER(name) LIKE :search OR LOWER(description) LIKE :search",
        search: search_string
      )
    end
    @products
  end

  def show
    @product = Product.includes(:category).find(params[:id])
  end
end
