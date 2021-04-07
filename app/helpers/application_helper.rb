module ApplicationHelper
  class Cart
    def initialize(cart)
      @products = []
      @ids = []
      @quantities = []

      cart.each do |item|
        puts item.inspect
        @products << Product.find(item["id"])
        @ids << item["id"]
        @quantities << item["quantity"]
      end
    end

    def products
      if @products.nil?
        []
      else
        @products
      end
    end

    attr_reader :ids, :quantities
  end
end
