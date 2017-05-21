class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :set_password
 # validates :birthday, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize
  end

  def self.new_with_session(params, session)
   super.tap do |user|
     if data = session['devise.wechat_data']
       user.provider = data['provider']
       user.uid = data['uid']
       #user.nickname = data['info']['nickname']
       #user.sex = data['info']['sex']
       #user.avatar = data['info']['headimgurl']
     end
   end
  end

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
