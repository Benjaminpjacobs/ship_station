RSpec.describe ShipStation::Customer do
   before do
    stub_api_for(ShipStation::Customer) do |stub|
      stub.get("/customers") do |env|
        [
          200,
          {},
          { customers: [{
                        "customerId": 12345678,
                        "createDate": "2014-11-18T10:33:01.1900000",
                        "modifyDate": "2014-11-18T10:33:01.1900000",
                        "name": "Cam Newton",
                        "company": "Test Company",
                        }],
            page: 1,
            pages: 1,
            total: 1
          }.to_json
        ]
      end

      stub.get("/customers/12345678") do |env|
        [
          200,
          {},
          {
            "customerId": 12345678,
            "createDate": "2014-11-18T10:33:01.1900000",
            "modifyDate": "2014-11-18T10:33:01.1900000",
            "name": "Cam Newton",
            "company": "Test Company",
            }.to_json
        ]
      end
    end
  end

  it "GET list" do
    customers = ShipStation::Customer.all.fetch
    expect(customers.length).to eq(1)
    expect(customers.metadata[:page]).to eq(1)
  end

  it "GET specific" do
    customer = ShipStation::Customer.find('12345678')
    expect(customer.company).to eq('Test Company')
  end

  it "GET search" do
    name = "Cam Newton"
    customers = ShipStation::Customer.where(name: name)
    customer = customers.first
    expect(customers.count).to eq(1)
    expect(customer.name).to eq(name)
  end
end
