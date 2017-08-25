source 'https://gems.ruby-china.org/'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use mysql2 as the database for Active Record
gem 'mysql2'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
#gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
#gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
#gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
#gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

# json active_model_serializers
gem 'active_model_serializers', '~> 0.10.0'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Query elasticsearch
gem 'elasticsearch-persistence'

# Use json web token
gem 'jwt'
# Use cancancan for authorization
gem 'cancancan'

# Use kaminari for pagination
gem 'kaminari'

gem 'rest-client'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#队列
gem 'sidekiq'
#定时任务
gem 'sidetiq'

gem 'audited'

# Revenue processing status
#gem 'state_machines'
#gem 'state_machines-activerecord'

# 软删除
gem 'acts_as_paranoid', '~> 0.5.0'

#日志输出
#gem 'awesome_print'
#gem 'rails_semantic_logger'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'workflow', '~> 1.2.0'

#export xlsx
gem 'axlsx_rails'

#import xlsx
gem "roo"

gem 'awesome_nested_set'

#add sentry exception log service
gem 'sentry-raven'

gem 'typhoeus'
