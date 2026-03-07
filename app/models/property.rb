class Property < ApplicationRecord
  validates :name, :address, :price, presence: true
  has_many_attached :images
end
