require "rails_helper"

RSpec.describe "Weather", type: :request do
  describe "GET /" do
    it "Loads the root page" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /weather" do
    it "returns weather for a valid location" do
      VCR.use_cassette("apple-hq") do
        get weather_path(location: "1 Apple Park Way")
        expect(response).to have_http_status(200)
      end
    end

    it "shows an error for an invalid location" do
      VCR.use_cassette("bad-geocode") do
        get weather_path(location: "hjgfwqrhvi")
        expect(response).to have_http_status(200)
        expect(response.body).to include("Location lookup failed")
      end
    end
  end
end
