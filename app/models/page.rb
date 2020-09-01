# DB stored pages "Contact" and "About" use this class
class Page < ApplicationRecord
  validates :title, presence: true
end
