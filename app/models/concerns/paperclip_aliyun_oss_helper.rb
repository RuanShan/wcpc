  # include into model
  module PaperclipAliyunOssHelper
    extend ActiveSupport::Concern

    # original path and url
    # :url  => "/shops/:rails_env/:site/ckeditor_assets/pictures/:id/:style_:basename.:extension",
    # :path => ":rails_root/public/shops/:rails_env/:site/ckeditor_assets/pictures/:id/:style_:basename.:extension",
    # include it after :has_attached_file
    included do
      if storage_aliyun?
        fix_path_for_aliyun_oss
      end
    end

    class_methods do
      def fix_path_for_aliyun_oss
        # ex. photo   path = photo/1_test.jpg,  :aliyun_style start with @
        # taxon/post/
        path = ":class/:id_:filename"
        #make sure each
        attachment_keys = [:photo, :logo]  # spree_image/ spree_template_file
        attachment_keys.each{|attachment_key|
          if attachment_definitions[attachment_key]
            attachment_definitions[attachment_key][:path] = path
            attachment_definitions[attachment_key][:url] = 'http://:aliyun_host/'+path+':aliyun_style'
            attachment_definitions[attachment_key][:styles] = {} #no need styles anymore. it is supproted by oss style
          end
        }
      end

      def storage_aliyun?
       (attachment_definitions[:storage]||Paperclip::Attachment.default_options[:storage]) == :aliyun
      end
    end
  end
