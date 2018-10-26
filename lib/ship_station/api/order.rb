module ShipStation
  class Order < Model
    shipstation_has_many :shipments, foreign_key: :orderNumber
    shipstation_belongs_to :customer, primary_key: :customerId
  end
end