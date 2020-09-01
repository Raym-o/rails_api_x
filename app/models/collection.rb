# Represents the categorical collections of Products available
class Collection < ApplicationRecord
  has_many :collection_products
  has_many :products, through: :collection_products

  validates :title, :description, presence: true
  validates :title, length: { maximum: 50 }
end
