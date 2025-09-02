import 'package:weather_app/models/forecast_model.dart';

class Weather {
  final DateTime dateTime;
  final double temperature;
  final double tempFeel;
  final String mainCondition;
  final int humidity;
  final double windSpeed;
  final DateTime sunrise;
  final DateTime sunset;
  final List<Forecast> forecast;

  Weather({
    required this.dateTime,
    required this.temperature,
    required this.tempFeel,
    required this.mainCondition,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.forecast,
  });

  //factory method to create a Weather instance from JSON data returned by the API
  factory Weather.fromJson(Map<String, dynamic> jsonResponse) {
    //check https://openweathermap.org/api/one-call-3
    List<Forecast> forecasts = List.empty(growable: true);
    for (final forecast in jsonResponse['daily']) {
      forecasts.add(
        Forecast.fromJson(forecast, jsonResponse['timezone_offset']),
      );
    }

    return Weather(
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        (jsonResponse['current']['dt'] + jsonResponse['timezone_offset']) *
            1000,
        isUtc: true,
      ),
      temperature: jsonResponse['current']['temp'],
      tempFeel: jsonResponse['current']['feels_like'],
      mainCondition: jsonResponse['current']['weather'][0]['main'],
      humidity: jsonResponse['current']['humidity'],
      windSpeed: jsonResponse['current']['wind_speed'],
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        (jsonResponse['current']['sunrise'] + jsonResponse['timezone_offset']) *
            1000,
        isUtc: true,
      ),
      sunset: DateTime.fromMillisecondsSinceEpoch(
        (jsonResponse['current']['sunset'] + jsonResponse['timezone_offset']) *
            1000,
        isUtc: true,
      ),
      forecast: forecasts,
    );
  }
}
