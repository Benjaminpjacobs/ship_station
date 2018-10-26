RSpec.describe ShipStation::Warehouse do
   before do
    stub_api_for(ShipStation::Warehouse) do |stub|
      stub.get("/warehouses") do |env|
        [
          200,
          {},
          [{
            "warehouseId": 17977,
            "warehouseName": "Main warehouse",
            "createDate": "2014-10-21T08:11:43.8800000",
            "isDefault": true
          },
          {
            "warehouseId": 14265,
            "warehouseName": "Austin",
            "createDate": "2014-05-27T09:54:29.9600000",
            "isDefault": false
          }].to_json
        ]
      end

      stub.get("/warehouses/17977") do |env|
        [
          200,
          {},
          {
            "warehouseId": 17977,
            "warehouseName": "Main warehouse",
            "createDate": "2014-10-21T08:11:43.8800000",
            "isDefault": true
          }.to_json
        ]
      end
    end
  end

  it "GET list" do
    warehouses = ShipStation::Warehouse.all.fetch
    expect(warehouses.length).to eq(2)
    expect(warehouses.metadata).to be_empty
  end

  it "GET specific" do
    store = ShipStation::Warehouse.find('17977')
    expect(store.warehouseName).to eq('Main warehouse')
  end
end
