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

  final _weatherService = WeatherService('c7775ef9efeb6db469bd98ae8fe21991'); //for test only
  Weather? _weather;

  //fetch weather info
  _fetchWeather() async {
    try {
      final weather = await _weatherService.getWeather(51.0447, 114.0719); //location for test only
      print(weather);
      setState(() {
        _weather = weather;
      });
    }
    catch (e) {
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
        title: Text(widget.username),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('${_weather?.temperature.round()}°C')
          ],
        ),
      ),
    );
  }
}
