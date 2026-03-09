class Property < ApplicationRecord
  validates :name, :address, :price, presence: true
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 100, 100 ]
    attachable.variant :detail, resize_to_limit: [ 200, 200 ]
  end
end
