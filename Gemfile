source 'http://production.s3.rubygems.org'

gem 'gaku', github: 'GAKUEngine/gaku'
#gem 'gaku', path: '../gaku'

group :test do
  gem 'rspec-rails',              '~> 2.14.1'
  gem 'factory_girl_rails',       '~> 4.4.0'
  gem 'database_cleaner',         '~> 1.2'
  gem 'shoulda-matchers',         '~> 2.5.0'
  gem 'capybara',                 '~> 2.1'
  gem 'selenium-webdriver',       '~> 2.39'
  gem 'poltergeist'
  gem 'launchy'
  gem 'handy_controller_helpers', '0.0.3'
  gem 'simplecov'
  gem 'rspec-retry'
  gem 'coveralls', require: false
end

unless ENV['TRAVIS']
  group :development do
    gem 'guard'
    gem 'rubocop'
    gem 'guard-rspec'
    gem 'guard-bundler'
    gem 'guard-rubocop'
  end
end

gemspec
