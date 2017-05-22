class Shop < ApplicationRecord
  has_many :cards
  validates :name, :intro, presence: true
end
