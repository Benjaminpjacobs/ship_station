module ShipStation
  class Customer < Model
    shipstation_has_many :orders, foreign_key: :customerId
  end
end