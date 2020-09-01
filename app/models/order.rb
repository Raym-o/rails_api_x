# Represents Orders placed by Users within the ecommerce web app
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products

  validates :status, :price, :pst, :gst, :hst, :customer, presence: true

  validates :status, inclusion: { in: %w[Unpaid Paid],
                                  message: '%{value} is not a valid status' }

  validates :price, :pst, :gst, :hst,
            numericality: { greater_than_or_equal_to: 0 }
end
