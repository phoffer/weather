require "rails_helper"

RSpec.describe Meteorologist do
  let(:apple_addr) { "1 Apple Park Way" }
  let(:zip) { "94087" }

  describe ".forecast" do
    it "retrieves the forecast for a valid location" do
      VCR.use_cassette("apple-hq") do
        data = described_class.forecast(apple_addr)
        expect(data.dig("current", "temperature_2m")).to eq(84.8)
      end
    end
  end

  describe ".cached_forecast" do
    it "should properly load a cached forecast" do
      # this is technically vulnerable to a microsecond rounding flakiness, but not adding Timecop or including Rails time helpers for this single example
      described_class.cache_forecast!(zip, {})
      expect(described_class.cached_forecast(zip)).to eq({"cache" => Time.now.to_i})
    end
  end
end
