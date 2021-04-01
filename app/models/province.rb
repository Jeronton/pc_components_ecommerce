class Province < ApplicationRecord
  has_many :customers

  validates :abbreviation, :name, presence: true
  validates :PST, :GST, :HST, numericality: { allow_nil: true }
  validate :has_a_tax

  def has_a_tax
    fields = %i[PST GST HST]

    errors.add(:base, "Please specify a tax") unless fields.any? { |field| send(field).present? }
  end
end
