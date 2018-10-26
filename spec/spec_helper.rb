require 'bundler/setup'
require 'simplecov'
require 'pry'

SimpleCov.start do
  add_filter '/spec'
end

require 'ship_station'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include(Module.new do
    def stub_api_for(klass)
      klass.use_api (api = Her::API.new)

      # Here, you would customize this for your own API (URL, middleware, etc)
      # like you have done in your application’s initializer
      api.setup url: "http://api.example.com" do |c|
        c.use ShipStation::Middleware::JSONRequest
        c.use ShipStation::Middleware::ResponseParser
        c.adapter(:test) { |s| yield(s) }
      end
    end
  end)
  
  
end