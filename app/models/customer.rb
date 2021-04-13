class Customer < ApplicationRecord
  belongs_to :province
  belongs_to :user
  has_many :orders

  validates :province, :first_name, :last_name, :email, :country, :city, :address_line1, :postal,
            presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def name
    "#{first_name} #{last_name}"
  end
end
