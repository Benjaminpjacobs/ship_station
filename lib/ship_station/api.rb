module ShipStation
  module V1
    API = Her::API.new

    def self.setup
      puts "Initializing API Setup"
      API.setup url: "https://ssapi.shipstation.com" do |c|
        #Authentication
        c.use Faraday::Request::BasicAuthentication, ShipStation.username, ShipStation.password

        # Request
        c.use ShipStation::Middleware::JSONRequest

        # Response
        c.use ShipStation::Middleware::ResponseParser

        # Adapter
        c.use Faraday::Adapter::NetHttp
      end
      puts "API Setup Complete."
    end
  end
end