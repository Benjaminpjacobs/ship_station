RSpec.describe ShipStation::Fulfillment do
   before do
    stub_api_for(ShipStation::Fulfillment) do |stub|
      stub.get("/fulfillments") do |env|
        [
          200,
          {},
          { fulfillments: [
              {
                "fulfillmentId": 33974374,
                "orderId": 191759016,
                "orderNumber": "101",
                "userId": "c9f06d74-95de-4263-9b04-e87095cababf",
                "customerEmail": "apisupport@shipstation.com",
                "trackingNumber": "783408231234",
                "createDate": "2016-06-07T08:50:50.0670000",
                "shipDate": "2016-06-07T00:00:00.0000000",
              },
              {
                "fulfillmentId": 246310,
                "orderId": 193699927,
                "orderNumber": "102",
                "userId": "c9f06d74-95de-4263-9b04-e87095cababf",
                "customerEmail": "apisupport@shipstation.com",
                "trackingNumber": "664756278745",
                "createDate": "2016-06-08T12:54:53.3470000",
                "shipDate": "2016-06-08T00:00:00.0000000",
              }
            ],
            page: 1,
            pages: 1,
            total: 2
          }.to_json
        ]
      end
    end
  end

  it "GET list" do
    fulfillments = ShipStation::Fulfillment.all.fetch
    expect(fulfillments.length).to eq(2)
    expect(fulfillments.metadata[:total]).to eq(2)
    expect(fulfillments.first.orderNumber).to eq("101")
    expect(fulfillments.last.orderNumber).to eq("102")
  end
end
