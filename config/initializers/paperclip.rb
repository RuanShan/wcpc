Paperclip.interpolates :aliyun_host do |attachment, style_name|
  #style_name is symbol
  case style_name
    when :original
      Paperclip::Attachment.default_options[:aliyun][:oss_host]
    else
      Paperclip::Attachment.default_options[:aliyun][:img_host]
  end
end

Paperclip.interpolates :aliyun_style do |attachment, style_name|
  #需要阿里云设置相应服务样式
  # style_name could be nil/sym/sytring
  case style_name
    when :original
      ''
    else      
      "/#{style_name|| 'default'}"
  end
end
