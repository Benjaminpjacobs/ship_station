module ShipStation
  class Model
    Her::API.setup
    include Her::Model
    use_api V1::API
    parse_root_in_json true, format: :active_model_serializers

    def self.associated
      @associated ||= {}
    end

    def self.shipstation_has_many(name, opts={})
      self.associated[name] = opts.merge(:relationship  => :has_many)
    end

    def self.shipstation_belongs_to(name, opts={})
      self.associated[name] = opts.merge(:relationship  => :belongs_to)
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