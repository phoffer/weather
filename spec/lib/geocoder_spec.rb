require "rails_helper"

RSpec.describe Geocoder do
  let(:apple_addr) { "1 Apple Park Way" }
  let(:apple_data) { {lat: "37.3355693", lon: "-122.0111491", zip: "94087"} }
  describe ".lookup" do
    it "returns lat/lon/zip for Apple HQ" do
      VCR.use_cassette("apple-hq") do
        data = described_class.lookup(apple_addr)
        expect(data).to eq(apple_data)
      end
    end

    it "throws an error for a bad request" do
      VCR.use_cassette("bad-geocode") do
        expect { described_class.lookup("hjgfwqrhvi") }.to raise_error(StandardError, "Location lookup failed")
      end
    end
  end
end
