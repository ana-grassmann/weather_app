import 'package:flutter/material.dart';
import 'package:weather_app/components/extraInfoCard.dart';
import 'package:weather_app/components/forecastList.dart';
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

  _fetchWeather() async {
    //get current location coordinates
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
    if (_loading || _weather == null) {
      return Scaffold(body: Text('Loading...'));
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Welcome, ${widget.username}!'),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //icon here
              Text(
                '${_weather?.temperature.round()}°C',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text(_locationName),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ExtraInfoCard(
                  humidity: _weather?.humidity ?? 0,
                  windSpeed: _weather?.windSpeed ?? 0,
                  sunrise: _weather!.sunrise,
                  sunset: _weather!.sunset,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ForecastList(forecasts: _weather?.forecast),
              ),
            ],
          ),
        ),
      );
    }
  }
}
