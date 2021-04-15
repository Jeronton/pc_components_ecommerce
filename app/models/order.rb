class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products
  has_many :products, through: :order_products
  accepts_nested_attributes_for :products, allow_destroy: true

  validates :customer, :total, :status, presence: true
  validate :has_a_tax
  # validates :stripe_session, uniqueness: true

  def has_a_tax
    fields = %i[PST GST HST]

    errors.add(:base, "Please specify a tax") unless fields.any? { |field| send(field).present? }
  end
end
