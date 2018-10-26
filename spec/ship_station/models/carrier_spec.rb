RSpec.describe ShipStation::Carrier do
   before do
    stub_api_for(ShipStation::Carrier) do |stub|
      stub.get("/carriers") do |env|
        [
          200,
          {},
          { carriers: [{
                      "name": "Stamps.com",
                      "code": "stamps_com",
                      "accountNumber": "SS123",
                      "requiresFundedAccount": true,
                      "balance": 24.27,
                      "nickname": nil,
                      "shippingProviderId": 12345,
                      "primary": true
                    }],
            page: 1,
            pages: 1,
            total: 1
          }.to_json
        ]
      end
    end
  end

  it "GET list" do
    carriers = ShipStation::Carrier.all.fetch
    expect(carriers.length).to eq(1)
    expect(carriers.metadata[:page]).to eq(1)
  end

  it "GET search" do
    code = "stamps_com"
    carriers = ShipStation::Carrier.where(code: code)
    carrier = carriers.first
    expect(carriers.count).to eq(1)
    expect(carrier.code).to eq(code)
  end
end
