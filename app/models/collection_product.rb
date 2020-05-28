# Relational model, linking the Products with the Collections they are associated with
class CollectionProduct < ApplicationRecord
  belongs_to :product
  belongs_to :collection
end
