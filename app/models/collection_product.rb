class CollectionProduct < ApplicationRecord
  belongs_to :product
  belongs_to :collection
end
