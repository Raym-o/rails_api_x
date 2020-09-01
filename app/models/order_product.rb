# Relational model, linking Orders with the Products they contain
class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :price, :order, :product, :quantity, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
end
