class Product < ApplicationRecord
  belongs_to :category
  has_many :order_products
  has_many :orders, through: :order_products
  accepts_nested_attributes_for :orders, allow_destroy: true
  has_one_attached :image_small
  has_one_attached :image_med
  has_one_attached :image_large

  validates :name, :price, presence: true
  validates :price, numericality: { only_integer: true, :greater_than_or_equal_to => 0 }
end
