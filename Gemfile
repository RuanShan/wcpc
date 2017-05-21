source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby '2.3.1'
gem 'rails', '~> 5.0.3'
gem 'sqlite3'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
group :development, :test do
  gem 'byebug', platform: :mri
end
group :development do
  gem 'web-console', '>= 3.3.0'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end
gem 'bootstrap', '~> 4.0.0.alpha3.1'
gem 'figaro'
gem 'devise'
gem 'high_voltage'
gem 'simple_form'
gem 'tinymce-rails'
gem 'tinymce-rails-langs'
gem 'paperclip'
gem 'wechat'
gem 'weui-rails'
gem 'will_paginate', '~> 3.1.0'
group :development do
  gem 'better_errors'
  gem 'hub', :require=>nil
  gem 'rails_apps_pages'
  gem 'rails_apps_testing'
  gem 'rails_layout'
  gem 'spring-commands-rspec'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end

if Gem.win_platform?
  #gem 'coffee-script-source', '1.8.0'
  #gem 'wdm', '>= 0.1.0'
  gem 'bcrypt-ruby', '3.1.1.rc1', :require => 'bcrypt'
end
