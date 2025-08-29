import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/contants.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  WeatherService();

  Future<Weather> getWeather(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
        '$OPEN_WEATHER_API_URL?lat=$lat&lon=$lon&appid=$OPEN_WEATHER_API_KEY',
      ),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<(double, double)> getCurrentLocationCoordinates() async {
    LocationPermission permission = await Geolocator.checkPermission();

    //get permission from user to access location
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //get current user coordinates
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
    );
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    return (position.latitude, position.longitude);
  }

  //Gets location name from coordinates
  Future<String> getCurrentLocationName(double lat, double lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

    return placemarks[0].locality ?? "";
  }
}
