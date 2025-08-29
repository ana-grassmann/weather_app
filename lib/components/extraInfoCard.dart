import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'iconInfoCard.dart';

class ExtraInfoCard extends StatelessWidget {
  final int humidity;
  final double windSpeed;
  final DateTime sunrise;
  final DateTime sunset;

  const ExtraInfoCard({
    super.key,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          IconInfoCard(
            info: "$humidity%",
            icon: Icon(Icons.water_drop, color: Colors.lightBlue),
          ),
          IconInfoCard(
            info: "$windSpeed Km/h",
            icon: Icon(Icons.air, color: Colors.white),
          ),
          IconInfoCard(
            info: DateFormat('HH:mm').format(sunrise),
            icon: Icon(Icons.wb_twilight, color: Colors.orange),
          ),
          IconInfoCard(
            info: DateFormat('HH:mm').format(sunset),
            icon: Icon(Icons.wb_twilight, color: Colors.deepOrange),
          ),
        ],
      ),
    );
  }
}
