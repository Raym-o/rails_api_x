# Representation of Product available in ecommerce web app
class Product < ApplicationRecord
  has_many :order_products
  has_many :orders, through: :order_products
  has_many :collection_products
  has_many :collections, through: :collection_products

  has_one_attached :image
end
