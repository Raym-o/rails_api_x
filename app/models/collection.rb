# Represents the categorical collections of Products available
class Collection < ApplicationRecord
  has_many :collection_products
  has_many :products, through: :collection_products
end
