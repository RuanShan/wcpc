class Activity < ApplicationRecord
  belongs_to :shop
  has_many :photographs

  validates :name, :intro, presence: true

  def vote_numbers
    photographs.sum(:vote_numbers)
  end
end
