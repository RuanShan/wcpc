class Card < ApplicationRecord
  belongs_to :shop
  validates :name, :origin, presence: true

  def assigned?
    User.where("card_status=1").first
  end

  def duration
    start_date.to_s+"——"+end_date.to_s
  end
end
