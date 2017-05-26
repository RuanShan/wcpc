class Api::V1::WechatsController < ApplicationController
  # For details on the DSL available within this file, see https://github.com/Eric-Guo/wechat#wechat_responder---rails-responder-controller-dsl
  wechat_responder

  on :text do |request, content|
    request.reply.text "echo: #{content}" # Just echo
  end

  on :event, with: 'subscribe' do |request|
    request.reply.text "#{request[:FromUserName]} subscribe now"
  end

  # http://www.cnblogs.com/xiaocainiao2hao/p/5731800.html
  # 用户未登录下单 -> 生成微信二维码 -> 用户扫码关注公众号 -> 查看订单详细信息 就完成了。
  # https://mp.weixin.qq.com/wiki?id=mp1443433542 生成带参数的二维码
  # 公众号收到未关注用户扫描qrscene_xxxxxx二维码时。注意此次扫描事件将不再引发上条的用户加关注事件
  on :scan, with: 'qrscene_20170530' do |request, ticket|
    Rails.logger.debug "Unsubscribe user #{request[:FromUserName]} Ticket #{ticket}"
    request.reply.text "谢谢关注，欢迎,请点击 <a href='http://wx-wcpc-staging.getstore.cn'>参加活动 </a>"
  end

end
