class Shop < ApplicationRecord
  validates :name, :intro, presence: true
end
