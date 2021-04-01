class Product < ApplicationRecord
  belongs_to :category
  has_many :orders_products
  has_many :orders, through: :orders_products

  validates :name, :price, presence: true
  validates :price, numericality: { only_integer: true }
end
