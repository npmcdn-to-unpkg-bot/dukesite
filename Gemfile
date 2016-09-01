source 'https://rubygems.org'
ruby "2.2.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Solve the loading problem between Turbolinks & jQuery
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use Haml to write HTML doc
gem 'haml'
# Use Bootstrap
gem 'bootstrap-sass', '~> 3.3.6'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'devise'
# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Wrapper to Amazon Product Advertising API
gem 'amazon-ecs'

# Pagination
gem 'will_paginate', '~> 3.1.0'

# Image Uploader
gem 'carrierwave'
gem 'mini_magick'
# Use fog for Amazon S3 storage
gem "fog"

# SEO
gem 'meta-tags'

# WYSIWYG Editor
gem 'tinymce-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'pry', '~> 0.10.3'
  gem 'rspec-rails', '~> 3.4'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'guard-rspec', require: false
  gem 'guard-spork'
  gem 'capybara'
  gem 'database_cleaner'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Database
  gem 'mysql2', '~> 0.3.20'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # preview email
  gem "letter_opener"
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

gem 'execjs'
gem 'therubyracer'