class Product < ApplicationRecord
  validates :name, :price, presence: true
  validates :price, numericality: { only_integer: true }

end
