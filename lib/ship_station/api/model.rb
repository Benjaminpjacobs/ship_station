module ShipStation
  class Model
    include Her::Model
    use_api V1::API
    parse_root_in_json true, format: :active_model_serializers

    class << self
      %w(where find create new save_existing destroy_existing).each do |name|
        define_method "#{name}" do |i|
          raise(ConfigurationError, "Shipstation username not configured") if ShipStation.username.nil?
          raise(ConfigurationError, "Shipstation password not configured") if ShipStation.password.nil?
          if i.is_a?(Hash)
            i.each do |key, value|
              i[key] = value.iso8601(3) if value.respond_to?(:iso8601)
            end
          end
          super(i)
        end
      end

      def all
        raise(ConfigurationError, "Shipstation username not configured") if ShipStation.username.nil?
        raise(ConfigurationError, "Shipstation password not configured") if ShipStation.password.nil?
        super
      end

      def associated
        @associated ||= {}
      end

      def shipstation_has_many(name, opts={})
        associated[name] = opts.merge(:relationship  => :has_many)
      end

      def shipstation_belongs_to(name, opts={})
        associated[name] = opts.merge(:relationship  => :belongs_to)
      end
    end

    def method_missing(name, *args, &block)
      association = self.class.associated.fetch(name)
      if association
        case association[:relationship]
        when :has_many
          foreign_key = association[:foreign_key]
          resource = name.to_s.singularize.capitalize.classify
          "ShipStation::#{resource}".constantize.where(foreign_key => self.send(foreign_key)).fetch
        when :belongs_to
          primary_key = association[:primary_key]
          resource = name.to_s.singularize.capitalize.classify
          "ShipStation::#{resource}".constantize.find(self.send(primary_key))
        else
          super
        end
      end
    end
  end
end