source 'https://rubygems.org'
ruby '2.0.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'
gem 'bcrypt-ruby'

# Use sqlite3 as the database for Active Record
group :development, :test do
  gem 'sqlite3', '1.3.8'
  gem 'rspec'
  gem 'guard'
  gem 'guard-rspec'
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'rspec-rails'
  gem 'childprocess'
end
group :test do
  gem 'capybara'
  gem 'selenium-webdriver', '2.35.1'
  gem 'libnotify', '0.8.0'
  gem 'factory_girl_rails'
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
end

gem 'bootstrap-sass', '~> 3.3.4'
gem 'sass-rails', '>= 3.2'
gem 'sprockets'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.1'
gem 'jquery-rails', '3.0.4'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end
