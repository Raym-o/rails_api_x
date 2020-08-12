# Class representing web app users.
class User < ApplicationRecord
  has_secure_password

  has_one :address, dependent: :destroy
  has_many :orders

  validates :f_name, :l_name, presence: true
  validates :username, :email, uniqueness: true
end
