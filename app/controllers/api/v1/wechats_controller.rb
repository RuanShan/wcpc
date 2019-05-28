class Api::V1::WechatsController < ApplicationController
  # For details on the DSL available within this file, see https://github.com/Eric-Guo/wechat#wechat_responder---rails-responder-controller-dsl
  wechat_responder

  on :text do |request, content|
    request.reply.text "echo: #{content}" # Just echo
  end

  # 成员进入应用的事件推送
  on :event, with: 'enter_agent' do |request|
    request.reply.text "诺恩健康乐园 | 晒宝贝吃饭最萌瞬间评选大赛开始啦！点击 <a href='http://wcpc.getstore.cn'>参与活动 </a>。"
  end

  on :event, with: 'subscribe' do |request|
    #request.reply.text "#{request[:FromUserName]} subscribe now"
    txt = <<END_OF_STRING
诺恩健康乐园 | 晒宝贝吃饭最萌瞬间评选大赛开始啦！
   
点击 <a href='http://wcpc.getstore.cn'>参与活动 </a>。
     
晒萌娃，PO萌餐，丰厚奖品等你拿！
     
晒出宝宝吃东西的可爱照片，并邀请好友助力投票，
即有机会赢得超越想象的心动大礼。
     
惊喜福利必将眷顾每一位超人妈咪以及英雄老爸！
END_OF_STRING

        request.reply.text txt

  end

  # http://www.cnblogs.com/xiaocainiao2hao/p/5731800.html
  # 用户未登录下单 -> 生成微信二维码 -> 用户扫码关注公众号 -> 查看订单详细信息 就完成了。
  # https://mp.weixin.qq.com/wiki?id=mp1443433542 生成带参数的二维码
  # 公众号收到未关注用户扫描qrscene_xxxxxx二维码时。注意此次扫描事件将不再引发上条的用户加关注事件
  on :scan, with: 'qrscene_20170530' do |request, ticket|
    Rails.logger.debug "Unsubscribe user #{request[:FromUserName]} Ticket #{ticket}"
txt = <<END_OF_STRING
诺恩健康乐园 | 晒宝贝吃饭最萌瞬间评选大赛开始啦！
 
点击 <a href='http://wcpc.getstore.cn'>参与活动 </a>。
 
晒萌娃，PO萌餐，丰厚奖品等你拿！
 
晒出宝宝吃东西的可爱照片，并邀请好友助力投票，
即有机会赢得超越想象的心动大礼。
 
惊喜福利必将眷顾每一位超人妈咪以及英雄老爸！
END_OF_STRING

    request.reply.text txt
  end

end
