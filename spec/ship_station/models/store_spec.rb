RSpec.describe ShipStation::Store do
   before do
    stub_api_for(ShipStation::Store) do |stub|
      stub.get("/stores") do |env|
        [
          200,
          {},
          { stores: [
            {
              "storeId": 22766,
              "storeName": "ShipStation Manual Store",
              "marketplaceId": 0,
              "marketplaceName": "ShipStation",
              "createDate": "2014-07-25T11:05:55.307",
              "modifyDate": "2014-11-12T08:45:20.55",
            },
            {
              "storeId": 25748,
              "storeName": "Ashley's Test WooCommerce",
              "marketplaceId": 36,
              "marketplaceName": "WooCommerce",
              "createDate": "2014-11-10T08:53:48.077",
              "modifyDate": "2014-12-03T14:53:50.557",
            }
          ],
            page: 1,
            pages: 1,
            total: 2
          }.to_json
        ]
      end

      stub.get("/stores/22766") do |env|
        [
          200,
          {},
          {
            "storeId": 22766,
            "storeName": "ShipStation Manual Store",
            "marketplaceId": 0,
            "marketplaceName": "ShipStation",
            "createDate": "2014-07-25T11:05:55.307",
            "modifyDate": "2014-11-12T08:45:20.55",
          }.to_json
        ]
      end
    end
  end

  it "GET list" do
    stores = ShipStation::Store.all.fetch
    expect(stores.length).to eq(2)
    expect(stores.metadata[:page]).to eq(1)
  end

  it "GET specific" do
    store = ShipStation::Store.find('22766')
    expect(store.storeName).to eq('ShipStation Manual Store')
  end

  it "GET search" do
    marketplaceId = 0
    stores = ShipStation::Store.where(marketplaceId: marketplaceId)
    store = stores.first
    expect(stores.count).to eq(2)
    expect(store.marketplaceId).to eq(marketplaceId)
  end
end
