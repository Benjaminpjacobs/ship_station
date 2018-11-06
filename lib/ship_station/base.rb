module ShipStation
  class ShipstationError < StandardError; end

  class AuthenticationError < ShipstationError; end
  class ConfigurationError < ShipstationError; end

  class << self
    extend ActiveSupport::Autoload

    attr_accessor :limit
    attr_accessor :remaining
    attr_accessor :reset_time

    def username
      @username ||= ENV["SHIPSTATION_API_KEY"]
    end

    def username=(arg)
      @username = arg
      ShipStation::V1.setup
      @password
    end

    def password
      @password ||= ENV["SHIPSTATION_API_SECRET"]
    end

    def password=(arg)
      @password = arg
      ShipStation::V1.setup
      @password
    end


  end
end

SS = ShipStation
SS::V1.setup if ShipStation.username && ShipStation.password