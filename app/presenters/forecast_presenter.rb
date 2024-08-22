class ForecastPresenter
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def cached?
    @data["cache"].present?
  end

  def cached_at
    if cached?
      Time.at(@data["cache"]).in_time_zone(timezone_long).strftime("%Y-%m-%d %-l:%M%P") if @data["cache"]
    end
  end

  def conditions
    {
      time: Time.parse("#{@data.dig("current", "time")} #{timezone}").strftime("%Y-%m-%d %-l:%M%P"),
      temperature: "#{@data.dig("current", "temperature_2m")} #{units[:temperature]}",
      low: "#{@data.dig("current", "temperature_2m")} #{units[:temperature]}",
      precipitation: "#{@data.dig("current", "precipitation")} #{units[:precipitation]}"
    }
  end

  def units
    {
      temperature: @data.dig("current_units", "temperature_2m"),
      precipitation: @data.dig("current_units", "precipitation")
    }
  end

  def daily
    @daily ||= @data.dig("daily", "time").map.with_index do |time, i|
      {
        date: time,
        low: @data.dig("daily", "temperature_2m_min", i),
        high: @data.dig("daily", "temperature_2m_max", i),
        precipitation: @data.dig("daily", "precipitation_sum", i)
      }
    end
  end

  def timezone
    @data["timezone_abbreviation"]
  end

  def timezone_long
    @data["timezone"]
  end
end
