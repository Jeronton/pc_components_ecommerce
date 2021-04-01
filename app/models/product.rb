class Product < ApplicationRecord
  belongs_to :category
  has_many :order_products
  has_many :orders, through: :order_products
  accepts_nested_attributes_for :orders, allow_destroy: true

  validates :name, :price, presence: true
  validates :price, numericality: { only_integer: true }
end
