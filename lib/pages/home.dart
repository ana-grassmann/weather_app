import 'package:flutter/material.dart';
import 'package:weather_app/components/extra_weather_info.dart';
import 'package:weather_app/components/forecast_list.dart';
import 'package:weather_app/components/loading.dart';
import 'package:weather_app/components/location.dart';
import 'package:weather_app/components/styled_app_bar.dart';
import 'package:weather_app/components/translucent_container.dart';
import 'package:weather_app/components/weather_animation.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/utils/location_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.username});

  final String username;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _weatherService = WeatherService();
  Weather? _weather;
  String _locationName = "";
  bool _loading = true;
  String? _error;

  Future<void> _fetchWeather() async {
    final (lat, lon) = await getCurrentLocationCoordinates();

    try {
      List<dynamic> results = await Future.wait([
        _weatherService.getWeather(lat, lon), //fetch weather info
        getCurrentLocationName(lat, lon), //fetch location name
      ]);
      setState(() {
        _weather = results[0];
        _locationName = results[1];
        _loading = false;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'Failed to fetch weather data';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Loading(info: "Getting the latest weather info...");
    }
    if (_error != null) {
      return Center(
        child: Text(_error!, style: const TextStyle(color: Colors.white)),
      );
    }
    if (_weather == null) {
      return const Center(
        child: Text('No weather data', style: TextStyle(color: Colors.white)),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightBlue, Colors.indigo],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: StyledAppBar(username: widget.username),
        body: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMainWeatherRow(),
                TranslucentContainer(
                  margin: const EdgeInsets.only(top: 15),
                  child: ExtraWeatherInfo(
                    humidity: _weather?.humidity ?? 0,
                    windSpeed: _weather?.windSpeed ?? 0,
                    sunrise: _weather!.sunrise,
                    sunset: _weather!.sunset,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ForecastList(forecasts: _weather?.forecast),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainWeatherRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_weather?.temperature.round()}°C',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            LocationText(locationName: _locationName),
          ],
        ),
        WeatherAnimation(mainCondition: _weather?.mainCondition ?? "Clear"),
      ],
    );
  }
}
