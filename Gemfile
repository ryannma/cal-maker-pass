source 'https://rubygems.org'

gem 'rails', '3.2.16'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :test, :development do
  gem 'sqlite3'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner'
  gem 'rspec-rails', '~> 2.14.0'
  gem 'simplecov'
  gem 'factory_girl_rails'
  gem 'selenium-webdriver', '~> 2.45.0'
  gem 'codeclimate-test-reporter', :require=>nil
end

group :production do
  gem 'pg'
end

gem 'rake'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'sprockets'

#views
gem 'haml'
gem 'inline_svg'
gem 'turbolinks'

#fake data TODO: remove after the app is finally deployed since they will not be needed
gem 'faker'
gem 'populator'

#search engine and suggestion engine
gem 'twitter-typeahead-rails'
gem 'searchkick'
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'bonsai-elasticsearch-rails'

#pagination
gem 'kaminari'

#authentication
gem 'rubycas-client'

gem 'jquery-turbolinks'

