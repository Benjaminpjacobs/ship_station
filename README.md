[![Version      ](https://img.shields.io/gem/v/ship_station.svg?maxAge=2592000)](https://rubygems.org/gems/ship_station)
[![Build Status ](https://travis-ci.com/Benjaminpjacobs/ship_station.svg)](https://travis-ci.com/Benjaminpjacobs/ship_station)
[![Maintainability](https://api.codeclimate.com/v1/badges/a1c730263b7724ae7002/maintainability)](https://codeclimate.com/github/Benjaminpjacobs/ship_station/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/a1c730263b7724ae7002/test_coverage)](https://codeclimate.com/github/Benjaminpjacobs/ship_station/test_coverage)
## Shipstation

Another Ruby wrapper for the ShipStation API.

## Installation

Add module to your Gemfile:

```ruby
gem 'ship_station'
```

Then run bundle to install the Gem:

```sh
bundle install
```

Set up your environment file with your Shipstation API key and secret:

```
SHIPSTATION_API_KEY: <YOUR SHIPSTATION KEY>
SHIPSTATION_API_SECRET: <YOUR SHIPSTATION SECRET>
```

If using the gem without an environment file, you can initialize these manually.
```ruby
ShipStation.username = <YOUR SHIPSTATION KEY>
ShipStation.password = <YOUR SHIPSTATION SECRET>
```


## Usage

This gem provides a collection of operations for use within the Shipstation API.

### List

List all records for a resource.

```ruby
Shipstation::Carrier.all
Shipstation::Customer.all
Shipstation::FulFillment.all
Shipstation::Order.all
Shipstation::Product.all
Shipstation::Shipment.all
Shipstation::Store.all
Shipstation::Warehouse.all
```

### Retrieve

Retrieve a single record of a resource.

```ruby
Shipstation::Customer.find(customer_id)
Shipstation::Customer.find(customer_id)
Shipstation::Order.find(order_id)
Shipstation::Product.find(product_id)
Shipstation::Shipment.find(shipment_id)
Shipstation::Store.find(store_id)
Shipstation::Warehouse.find(warehouse_id)
```

### Pagination
After making a request, pagination can be retreived off the collection.

```ruby
orders = Shipstation::Order.all
orders.metadata[:page]  #=> 1
orders.metadata[:pages] #=> 3
orders.metadata[:total] #=> 250
```

### Rate Limiting

After making a request, rate limit information(expressed as an integer of seconds) can be retreived off the module.

```ruby
orders = Shipstation::Order.all
Shipstation.limit       #=> 40
Shipstation.remaining   #=> 39
Shipstation.reset_time  #=> 52

```

## How to contribute

* Fork the project
* Create your feature or bug fix
* Add the requried tests for it.
* Commit (do not change version or history)
* Send a pull request against the *development* branch

## Copyright
Copyright (c) 2018 Ben Jacobs
Licenced under the MIT licence.

