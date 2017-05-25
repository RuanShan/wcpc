Paperclip.interpolates :aliyun_host do |attachment, style_name|
  #style_name is symbol
  case style_name
    when :original
      Paperclip::Attachment.default_options[:aliyun][:oss_host]
    else
      Paperclip::Attachment.default_options[:aliyun][:img_host]
  end
end
