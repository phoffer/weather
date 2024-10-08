class WeatherController < ApplicationController
  def index
    # landing page with address form
  end

  def weather
    @forecast = ForecastPresenter.new(Meteorologist.forecast(params[:location]))
  rescue => e
    @error = e.message
  end
end
