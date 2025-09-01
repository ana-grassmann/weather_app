import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'icon_with_info.dart';

class ExtraWeatherInfo extends StatelessWidget {
  final int humidity;
  final double windSpeed;
  final DateTime sunrise;
  final DateTime sunset;

  const ExtraWeatherInfo({
    super.key,
    this.humidity = 0,
    this.windSpeed = 0.0,
    required this.sunrise,
    required this.sunset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: [
          IconWithInfo(
            info: "$humidity%",
            icon: Icon(Icons.water_drop, color: Colors.indigo),
          ),
          IconWithInfo(
            info: "$windSpeed Km/h",
            icon: Icon(Icons.air, color: Colors.white),
          ),
          IconWithInfo(
            info: DateFormat('HH:mm').format(sunrise),
            icon: Icon(Icons.wb_twilight, color: Colors.orange),
          ),
          IconWithInfo(
            info: DateFormat('HH:mm').format(sunset),
            icon: Icon(Icons.wb_twilight, color: Colors.deepOrange),
          ),
        ],
      ),
    );
  }
}
