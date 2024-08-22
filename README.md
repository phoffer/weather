# README

This is an app to demo getting a weather forecast from an address (or otherwise geocodable string).

## Setup

The only system dependencies are Ruby, Node, and Yarn. This app does not include a data store of any kind. The setup instructions are for `asdf` users; for others, see the versions required in `.tool-versions`.

```bash
git clone git@github.com:phoffer/weather.git
cd weather
asdf install
bundle install
yarn install
```

## Running the app

After having the dependencies installed, run the app with `bin/dev`.

## Architecture

There are 3 main modules that handle the business logic.

1. Geocoder
1. Weather
1. Meteorologist

### Geocoder

Geocoder is responsible for taking an address and performing geocoding via the Nominatim service from OpenStreetMap. It will return latitude, longitude, and zip code for a given search. If there is not a result, it will raise an error.

### Weather

Weather accepts latitude and longitude, and will request a weather forecast from the Open-Meteo service. This will return the current weather conditions (temperature and precipitation), and also those conditions for the next 7 days. If there is an issue performing this request, it will raise an error.

### Meteoroligst

Meteorologist is responsible for the primary action of gathering weather conditions for a given address. It accepts an address, utilizes `Geocoder` and `Weather` to geocode and get the weather information, and it also handles the caching of weather forecasts by zip code.

## Shortcomings

### External requests

There is some incongruence between our desires for caching, and our techniques for geocoding and requesting weather. Mainly, that we want to cache weather by zip code, but we do not necessarily require zip code in the search. We accept any geocodable input. Due to this, we must perform a geocode for each request in the current design. After finding the zip code, we are then able to check cache for a weather forecast.

This means the scalability of this current design is rather low, and it would take either a UX redesign (request weather by zip code only) or backend changes (creating our own geographic dataset) to improve.

