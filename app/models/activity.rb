class Activity < ApplicationRecord
  belongs_to :shop
  has_many :photographs
  has_many :coupons

  validates :name, :intro, presence: true

  def vote_numbers
    photographs.sum(:vote_numbers)
  end
end
