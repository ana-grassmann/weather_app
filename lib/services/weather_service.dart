import 'dart:convert';

import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const OPEN_WEATHER_API_URL = 'https://api.openweathermap.org/data/3.0/onecall';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(double lat, double lon) async {
    final response = await http.get(Uri.parse('$OPEN_WEATHER_API_URL?lat=$lat&lon=$lon&appid=$apiKey'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Failed to load weather data');
    }
  }
}