# Represents the mailing and billing address of a user.
class Address < ApplicationRecord
  belongs_to :user

  validates :line_1, :postal_code, presence: true
end
