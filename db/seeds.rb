# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

shop = Shop.create!(name:'请填写企业名称', intro:'企业介绍哦')
puts 'CREATED SHOP 1'

activity = Activity.create!(
  name:'请填写活动名称',
  intro:'活动介绍哦',
  traffic:0,
  start_time:DateTime.current,
  terminate_time:DateTime.current.since(1.month),
  shop:shop
)
puts 'CREATED ACTIVITY 1'
