module ShipStation
  module V1
    API = Her::API.new
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
  end
end