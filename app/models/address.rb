# Represents the mailing and billing address of a User.
class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  validates :line_1, :postal_code, presence: true

  validates :postal_code, format: {
    with: /[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJ-NPRSTV-Z][ ]?\d[ABCEGHJ-NPRSTV-Z]\d/,
    message: 'must be a valid Canadian postal code'
  }
end
