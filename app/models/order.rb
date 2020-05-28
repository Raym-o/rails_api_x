# Represents Orders placed by Users within the ecommerce web app
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products
end
