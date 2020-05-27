# Represents the provinces of Canada
class Province < ApplicationRecord
  has_many :addresses
end
