module ShipStation
  module Middleware
    class ResponseParser < Her::Middleware::FirstLevelParseJSON
      def parse(env)
        json = parse_json(env)

        return super unless json.is_a?(Hash)

        errors = json.delete(:errors) || {}
        pagination = json.slice(:page, :pages, :total)
        {
          :data => json.except(:page, :pages, :total),
          :errors => errors,
          :metadata => pagination
        }
      end

      # This middleware gives the user access to rate limiting information
      def on_complete(env)
        ShipStation.limit      = env.response.headers["x-rate-limit-limit"].to_i
        ShipStation.remaining  = env.response.headers["x-rate-limit-remaining"].to_i
        ShipStation.reset_time = env.response.headers["x-rate-limit-reset"].to_i
        super(env)
      end
    end

    # This middleware adds a "Content-Type: application/json" HTTP header
    class JSONRequest < Faraday::Middleware
      # @private
      def add_header(headers)
        headers.merge! "Content-Type" => "application/json"
      end

      # @private
      def call(env)
        # puts "########Request Url############"
        # puts env.url
        # puts "###############################"
        unless env.method == :get
          env[:body] = encode env[:body] unless env[:body].respond_to?(:to_str)
        end
        @app.call(env)
      end
    end
  end

end
