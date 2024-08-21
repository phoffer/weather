require "rails_helper"

RSpec.describe Weather do
  let(:apple_lat) { "37.3355693" }
  let(:apple_lon) { "-122.0111491" }
  describe ".request_weather_data" do
    it "returns weather data for Apple HQ" do
      VCR.use_cassette("apple-hq") do
        data = described_class.request_weather_data(apple_lat, apple_lon)
        expect(data.dig("current", "temperature_2m")).to eq(84.8)
      end
    end

    it "throws an error for a bad request" do
      VCR.use_cassette("bad-weather") do
        expect { described_class.request_weather_data("apple_lat", "apple_lon") }.to raise_error(StandardError, "Forecast lookup failed")
      end
    end
  end
end
