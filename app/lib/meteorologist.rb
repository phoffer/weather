module Meteorologist
  def self.forecast(address)
    geo = Geocoder.lookup(address)
    forecast = cached_forecast(geo[:zip])
    return forecast if forecast
    get_forecast(**geo)
  end

  def self.get_forecast(zip:, lat:, lon:)
    Weather.request_weather_data(lat, lon).tap do |forecast|
      cache_forecast!(zip, forecast)
    end
  end

  def self.cached_forecast(zip)
    Rails.cache.read("forecast-#{zip}")
  end

  def self.cache_forecast!(zip, forecast)
    Rails.cache.write("forecast-#{zip}", forecast.merge({"cache" => Time.now.to_i}), expires_in: 30.minutes)
  end
end
