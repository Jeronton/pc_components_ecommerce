class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).all
    category_id = begin
      Integer(params[:category])
    rescue StandardError
      -1
    end
    @category = Category.find(Integer(params[:category])) unless category_id < 0
    @products = @products.where(category_id: params[:category]) unless category_id < 0
  end

  def show
    @product = Product.includes(:category).find(params[:id])
  end
end
