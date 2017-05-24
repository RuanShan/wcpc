class Card < ApplicationRecord
  belongs_to :shop
  validates :name, :origin, presence: true

  def assigned?
    User.where("card_status=1").first
  end

  def duration
    start_date.strftime("%Y.%m.%d")+"——"+end_date.strftime("%Y.%m.%d")
  end

  def outer_url
    url ? url : ""
  end
end
