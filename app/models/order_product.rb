class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order, :product, :price, :quantity, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
