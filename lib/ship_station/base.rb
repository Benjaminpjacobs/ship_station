module ShipStation
  class ShipstationError < StandardError; end

  class AuthenticationError < ShipstationError; end
  class ConfigurationError < ShipstationError; end

  class << self
    extend ActiveSupport::Autoload

    attr_writer :username
    attr_writer :password

    attr_accessor :limit
    attr_accessor :remaining
    attr_accessor :reset_time

    def username
      @username ||= ENV["SHIPSTATION_API_KEY"] or
      raise(ConfigurationError, "Shipstation username not configured")
    end

    def password
      @password ||= ENV["SHIPSTATION_API_SECRET"] or
      raise(ConfigurationError, "Shipstation password not configured")
    end

  end
end

SS = ShipStation