class Vote < ApplicationRecord
  belongs_to :photograph
  belongs_to :user
  validates :user_id, uniqueness: { scope: :photograph_id,
    message: "您已经投过票啦！" }
  validates :must_active




  def must_active

    activity = self.photograph.activity
    if activity.terminate_time < DateTime.current
      errors.add(:base, '活动已经结束！无法投票，谢谢关注')
    end
  end
end
