class Property < ApplicationRecord
  validates :name, :address, :price, presence: true
end
