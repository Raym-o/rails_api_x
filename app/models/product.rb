# Representation of Product available in ecommerce web app
class Product < ApplicationRecord
  has_many :order_products
  has_many :orders, through: :order_products
  has_many :collection_products
  has_many :collections, through: :collection_products
  accepts_nested_attributes_for :collection_products, allow_destroy: true

  has_many_attached :images

  scope :with_eager_loaded_images, -> { eager_load(images_attachments: :blob) }
end
