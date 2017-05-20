class Coupon < ApplicationRecord
  belongs_to :activity

  def user_name
    user = User.find(user_id) if user_id.present?
    user ? user.name : "未领取"
  end
end
