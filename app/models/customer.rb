class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders

  validates :province, :first_name, :last_name, :email, :country, :city, :address_line1, :postal,
            presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
