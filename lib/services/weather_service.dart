import 'dart:convert';
import 'package:weather_app/contants.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  WeatherService();

  Future<Weather> getWeather(double lat, double lon) async {
    final unitSystem = "metric";
    final response = await http.get(
      Uri.parse(
        '$OPEN_WEATHER_API_URL?lat=$lat&lon=$lon&units=$unitSystem&appid=$OPEN_WEATHER_API_KEY',
      ),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
