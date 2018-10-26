RSpec.describe ShipStation do
  it "raises configurations error if missing API key" do
    ENV["SHIPSTATION_API_KEY"] = nil
    ShipStation.username = nil
    expect{ ShipStation.username }.to raise_error(ShipStation::ConfigurationError)
  end

  it "raises configurations error if missing API secret" do
    ENV["SHIPSTATION_API_SECRET"] = nil
    ShipStation.password = nil
    expect{ ShipStation.password }.to raise_error(ShipStation::ConfigurationError)
  end

  it "stores rate limiting information after each request" do
    stub_api_for(ShipStation::Order) do |stub|
      stub.get("/orders") do |env|
        [
          200,
          {
            "x-rate-limit-limit" => 40,
            "x-rate-limit-remaining" => 39,
            "x-rate-limit-reset"=>20
          },
          { orders: [{}],
            page: 1,
            pages: 1,
            total: 1
          }.to_json
        ]
      end
    end

    ShipStation::Order.all.fetch

    expect(ShipStation.limit).to eq(40)
    expect(ShipStation.remaining).to eq(39)
    expect(ShipStation.reset_time).to eq(20)
  end
end