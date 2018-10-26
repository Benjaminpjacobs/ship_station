RSpec.describe ShipStation::Product do
   before do
    stub_api_for(ShipStation::Product) do |stub|
      stub.get("/products") do |env|
        [
          200,
          {},
          { products: [
              {
                "aliases": nil,
                "productId": 7854008,
                "sku": "1005",
                "name": "Coffee Mug",
                "warehouseLocation": "Bin 22"
              },
              {
                "aliases": nil,
                "productId": 7854009,
                "sku": "1005",
                "name": "Coffee Filter",
                "warehouseLocation": "Bin 22"
              }
            ],
            page: 1,
            pages: 1,
            total: 2
          }.to_json
        ]
      end

      stub.get("/products/7854008") do |env|
        [
          200,
          {},
          {
            "aliases": nil,
            "productId": 7854008,
            "sku": "1005",
            "name": "Coffee Mug"
          }.to_json
        ]
      end
    end
  end

  it "GET list" do
    products = ShipStation::Product.all.fetch
    expect(products.length).to eq(2)
    expect(products.metadata[:total]).to eq(2)
  end

  it "GET specific" do
    product = ShipStation::Product.find('7854008')
    expect(product.sku).to eq('1005')
  end

  it "GET search" do
    warehouseLocation = "Bin 22"
    products = ShipStation::Product.where(warehouseLocation: warehouseLocation)
    product = products.first
    expect(products.count).to eq(2)
    expect(product.warehouseLocation).to eq(warehouseLocation)
  end
end
