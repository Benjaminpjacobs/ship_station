RSpec.describe ShipStation::Shipment do
   before do
    stub_api_for(ShipStation::Shipment) do |stub|
      stub.get("/shipments") do |env|
        [
          200,
          {},
          { shipments: [{
              shipmentId: 33974374,
              orderId: 43945660,
              orderKey: "8061c220f0794a9b92460b8bae6837e4",
              userId: "123456AB-ab12-3c4d-5e67-89f1abc1defa",
              orderNumber: "100038-1",
              createDate: "2014-10-03T06:51:33.6270000",
              shipDate: "2014-10-03",
              shipmentCost: 1.93,
              insuranceCost: 0,
              trackingNumber: "9400111899561704681189"}],
            page: 1,
            pages: 1,
            total: 1
          }.to_json
        ]
      end

      stub.get("/shipments/33974374") do |env|
        [
          200,
          {},
          {
            shipmentId: 33974374,
            orderId: 43945660,
            orderKey: "8061c220f0794a9b92460b8bae6837e4",
            userId: "123456AB-ab12-3c4d-5e67-89f1abc1defa",
            orderNumber: "100038-1",
            createDate: "2014-10-03T06:51:33.6270000",
            shipDate: "2014-10-03",
            shipmentCost: 1.93,
            insuranceCost: 0,
            trackingNumber: "9400111899561704681189"
          }.to_json
        ]
      end
    end
  end

  it "GET list" do
    shipments = ShipStation::Shipment.all.fetch
    expect(shipments.length).to eq(1)
    expect(shipments.metadata[:page]).to eq(1)
  end

  it "GET specific" do
    shipment = ShipStation::Shipment.find('33974374')
    expect(shipment.orderNumber).to eq('100038-1')
  end

  it "GET search" do
    orderNumber = "100038-1"
    shipments = ShipStation::Shipment.where(orderNumber: orderNumber)
    shipment = shipments.first
    expect(shipments.count).to eq(1)
    expect(shipment.orderNumber).to eq(orderNumber)
  end
end
