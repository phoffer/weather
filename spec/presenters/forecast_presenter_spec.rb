require "rails_helper"

RSpec.describe ForecastPresenter do
  let(:file) { "spec/fixtures/json/forecast.json" }
  let(:json) { JSON.parse(File.read(file)) }
  subject { described_class.new(json) }

  describe "#conditions" do
    it "presents the current weather conditions" do
      expect(subject.conditions).to eq({
        low:           "69.8 °F",
        precipitation: "0.0 inch",
        temperature:   "69.8 °F",
        time:          "2024-08-21 7:30pm"
      })
    end
  end

  describe "#daily" do
    it "presents the daily weather" do
      expect(subject.daily).to eq([
        {date: "2024-08-21", high: 79.8, low: 58.7, precipitation: 0.0},
        {date: "2024-08-22", high: 75.0, low: 55.9, precipitation: 0.0},
        {date: "2024-08-23", high: 72.7, low: 54.0, precipitation: 0.0},
        {date: "2024-08-24", high: 77.1, low: 60.7, precipitation: 0.0},
        {date: "2024-08-25", high: 86.1, low: 60.9, precipitation: 0.0},
        {date: "2024-08-26", high: 92.9, low: 65.4, precipitation: 0.0},
        {date: "2024-08-27", high: 90.8, low: 68.7, precipitation: 0.0}
     ])
    end
  end

  describe "#cached_at" do
    it "presents the daily weather" do
      expect(subject.cached_at).to be_nil
    end
  end

  context "cached result" do
    let(:time) { Time.now.to_i }
    let(:json) { JSON.parse(File.read(file)).merge("cache" => time) }

    describe "#cached_at" do
      it "displays the cached time" do
        expect(subject.cached_at).to eq(Time.at(time).in_time_zone("US/Pacific").strftime("%Y-%m-%d %-l:%M%P"))
      end
    end
  end
end
