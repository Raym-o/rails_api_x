# Represents the mailing and billing address of a User.
class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  validates :line_1, :postal_code, presence: true
end
