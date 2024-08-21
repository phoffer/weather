class WeatherController < ApplicationController
  def index
    # landing page with address form
  end

  def weather
    @forecast = Meteorologist.forecast(params[:location])
  rescue Exception => e
    @error = e.message
  end
end
