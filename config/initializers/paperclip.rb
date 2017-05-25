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
  case style_name.to_sym
    when :px400
      '?x-oss-process=style/'+style_name
    else
      # 缺省使用原图
      ''
  end

end
