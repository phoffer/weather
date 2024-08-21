require "net/http"
require "json"

module Weather
  def self.request_weather_data(lat, lon)
    uri = URI(url(lat, lon))
    headers = {"Content-Type" => "application/json", "User-Agent" => "Hoffer Apple Coding Test"}
    response = Net::HTTP.get(uri, headers)
    res = JSON.parse(response)
    raise Exception.new("Forecast lookup failed") if res["error"]
    res
  end

  def self.url(lat, lon)
    "https://api.open-meteo.com/v1/forecast?latitude=#{lat}&longitude=#{lon}&current=temperature_2m,precipitation,weather_code&hourly=temperature_2m,precipitation,weather_code&daily=temperature_2m_max,temperature_2m_min,precipitation_sum,rain_sum,precipitation_hours&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch&timezone=auto"
  end
end
