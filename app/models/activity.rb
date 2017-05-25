class Activity < ApplicationRecord
  belongs_to :shop
  has_many :photographs
  has_many :coupons

  validates :name, :intro, presence: true

  def vote_numbers
    photographs.sum(:vote_numbers)
  end

  def duration
    start_time.strftime("%Y.%m.%d")+"至"+terminate_time.strftime("%Y.%m.%d")
  end
end
