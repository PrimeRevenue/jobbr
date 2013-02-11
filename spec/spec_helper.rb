ENV['RAILS_ENV'] ||= 'test'

require 'rails/mongoid'
require File.join(File.dirname(__FILE__), 'dummy', 'config', 'environment.rb')
require 'rspec/rails'
require 'database_cleaner'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), 'support', '**', '*.rb')].each { |f| require f }

RSpec.configure do |config|

  config.mock_with :mocha
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.orm = 'mongoid'
  end

  config.before(:each) do
    Mongoid::IdentityMap.clear
  end

  config.before(:each) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.after(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

end