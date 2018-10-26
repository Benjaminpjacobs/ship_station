module ShipStation
  class Shipment < Model
    shipstation_belongs_to :order, primary_key: :orderId
  end
end