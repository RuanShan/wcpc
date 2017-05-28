class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :set_password, on: :create

  has_many :photographs, dependent: :destroy
  self.per_page = 3

  def email_required?
   false
  end

  def update_info(user_info)
    #"nickname"=>"abc", "sex"=>2, "language"=>"zh_CN", "city"=>"大连", "province"=>"辽宁", "country"=>"中国", "headimgurl"=>"imgurl", "privilege"=>[]
    self.nickname=user_info["nickname"]
    self.gender=user_info["sex"]
    self.city=user_info["city"]
    self.province=user_info["province"]
    self.country=user_info["country"]
    self.avatar=user_info["headimgurl"]
    self.save
  end

  private

  def set_password
    self.password ||= Devise.friendly_token[0, 20]
  end
end
