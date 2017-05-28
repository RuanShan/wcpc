class Photograph < ApplicationRecord
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/pic_160.png"
  include PaperclipAliyunOssHelper

  belongs_to :activity
  belongs_to :user
  has_many :votes
  has_many :photos, dependent: :destroy
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  accepts_nested_attributes_for :photos, allow_destroy: true
  accepts_nested_attributes_for :user, allow_destroy: false

  validates :photos, presence: true
  validates :name, length: { in: 2..15 }
  validates :intro, length: { in: 2..60 }

  after_create :get_card

  cattr_accessor :upload_limit

  self.per_page = 6
  self.upload_limit = 1

  def cover_url(psize=nil)
    return photos.first.photo.url(psize)
    #photo ? photo.url(psize) : photos.first.photo.url(psize)
  end

  def vote(wechat_user_id)
    vote = self.votes.create(user_id:wechat_user_id)
    if vote
      self.vote_numbers = self.vote_numbers.to_i+1
      self.save
    end
    return vote
  end

  def get_card
    wx_user = self.user
    wx_user.card_status = 1
    wx_user.save
    #coupon = Coupon.where(user_id: nil).first
    #if coupon.present?
    #  coupon.user_id=user_id
    #  coupon.save
    #end
  end
end
