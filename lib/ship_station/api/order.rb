module ShipStation
  class Order < Model
    shipstation_has_many :shipments, foreign_key: :orderNumber
    shipstation_belongs_to :customer, primary_key: :customerId

    def all(args)
      use_api V1::API
      super(args)
    end
  end
end