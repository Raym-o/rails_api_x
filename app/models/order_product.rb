# Relational model, linking Orders with the Products they contain
class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order
end
