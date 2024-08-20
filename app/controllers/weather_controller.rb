class WeatherController < ApplicationController
  def index
    # landing page with address form
  end

  def weather
    @forecast = Meteorologist.forecast(params[:location])
    # display forecast for params[:q]
  end
end
