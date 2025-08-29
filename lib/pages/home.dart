import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.username});

  final String username;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _weatherService = WeatherService();
  Weather? _weather;
  String? _locationName;

  //fetch weather info
  _fetchWeather() async {
    final (lat, lon) = await _weatherService.getCurrentLocationCoordinates();

    try {
      List<dynamic> results = await Future.wait([
        _weatherService.getWeather(lat, lon),
        _weatherService.getCurrentLocationName(lat, lon),
      ]);

      setState(() {
        _weather = results[0];
        _locationName = results[1];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Welcome, ${widget.username}!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_locationName ?? "Loading location.."),
            Text('${_weather?.temperature.round()}°C'),
          ],
        ),
      ),
    );
  }
}
