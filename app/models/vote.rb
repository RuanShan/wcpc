class Vote < ApplicationRecord
  belongs_to :photograph
  belongs_to :user
  validates :user_id, uniqueness: { scope: :photograph_id,
    message: "您已经投过票啦！" }
end
