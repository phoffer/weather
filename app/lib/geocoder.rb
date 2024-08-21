require "net/http"
require "json"

module Geocoder
  def self.lookup(query)
    data = request_geo_data(query).dig(0)
    raise StandardError.new("Location lookup failed") unless data
    {
      zip: data.dig("address", "postcode"),
      lat: data.dig("lat"),
      lon: data.dig("lon")
    }
  end

  def self.request_geo_data(query)
    uri = URI(url(query))
    headers = {"Content-Type" => "application/json", "User-Agent" => "Hoffer Apple Coding Test"}
    response = Net::HTTP.get(uri, headers)
    JSON.parse(response)
  end

  def self.url(query)
    "https://nominatim.openstreetmap.org/search?q=#{query}&format=jsonv2&addressdetails=1"
  end
end
