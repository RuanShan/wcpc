class Shop < ApplicationRecord
  has_many :cards
  has_attached_file :logo, styles: { big: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/pic_160.png"
  include PaperclipAliyunOssHelper

  validates_attachment :logo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates :name, :intro, presence: true
end
