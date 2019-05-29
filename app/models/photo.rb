class Photo < ApplicationRecord
  has_attached_file :photo, styles: { big: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/pic_160.png"
  include PaperclipAliyunOssHelper

  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }


  #https://stackoverflow.com/questions/27234065/how-to-upload-a-base-64-image-to-rails-paperclip
  attr_accessor :base64_image

  before_validation :save_base64_image

  # call this explicitly from the controller or in an after_save callback
  # after setting the base64_image attribute
  def save_base64_image
   if base64_image.present?
       adapter = Paperclip.io_adapters.for(base64_image)
       adapter.original_filename = "base64.jpg"
       self.photo = adapter
     end
  end
  
end
