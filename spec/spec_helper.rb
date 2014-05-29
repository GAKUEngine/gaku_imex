ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)

require 'gaku/testing/spec_helpers/spec_helper'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require 'sidekiq'
require 'sidekiq/testing'
require 'paperclip/matchers'

RSpec.configure do |config|
   config.include Paperclip::Shoulda::Matchers
end