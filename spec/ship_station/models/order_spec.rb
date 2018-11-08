RSpec.describe ShipStation::Order do
   before do
    stub_api_for(ShipStation::Order) do |stub|
      stub.get("/orders") do |env|
        [
          200,
          {},
          { orders: [{
                      "orderId"=>9222306,
                      "orderNumber"=>"1918",
                      "orderKey"=>"3991397126",
                      "orderDate"=>"2016-08-08T16:48:30.0000000",
                      "createDate"=>"2016-11-02T08:01:53.1400000",
                      "modifyDate"=>"2016-11-02T08:01:46.3970000"
                      }],
            page: 1,
            pages: 1,
            total: 1
          }.to_json
        ]
      end

      stub.get("/orders/9222306") do |env|
        [
          200,
          {},
          {
            "orderId"=>9222306,
            "orderNumber"=>"1918",
            "orderKey"=>"3991397126",
            "orderDate"=>"2016-08-08T16:48:30.0000000",
            "createDate"=>"2016-11-02T08:01:53.1400000",
            "modifyDate"=>"2016-11-02T08:01:46.3970000"
          }.to_json
        ]
      end
    end
  end

  it "GET list" do
    orders = ShipStation::Order.all.fetch
    expect(orders.length).to eq(1)
    expect(orders.metadata[:page]).to eq(1)
  end

  it "GET specific" do
    order = ShipStation::Order.find('9222306')
    expect(order.orderNumber).to eq('1918')
  end

  it "GET search" do
    orderNumber = "1918"
    orders = ShipStation::Order.where(orderNumber: orderNumber)
    order = orders.first
    expect(orders.count).to eq(1)
    expect(order.orderNumber).to eq(orderNumber)
  end

  it "converts date info to time" do
    Time.zone = "Eastern Time (US & Canada)"
    modifyDateEnd = 3.minutes.ago
    orders = ShipStation::Order.where(modifyDateEnd: modifyDateEnd)
    expect(orders.params[:modifyDateEnd]).to be_a(Time)
  end
end
