class Order < ApplicationRecord
  belongs_to :customer

  validates :customer, :total, :status, presence: true
  validate :has_a_tax

  def has_a_tax
    fields = %i[PST GST HST]

    errors.add(:base, "Please specify a tax") unless fields.any? { |field| send(field).present? }
  end
end
