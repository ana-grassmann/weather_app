import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

//widget that shows a weather icon based on the main weather condition
class WeatherIcon extends StatelessWidget {
  final String mainCondition;
  final Color color;

  const WeatherIcon({
    super.key,
    this.mainCondition = "Clear",
    this.color = Colors.white,
  });

  //mapping of main weather conditions to corresponding material symbols icons
  static const _iconMap = {
    'clear': Symbols.wb_sunny,
    'clouds': Symbols.cloud,
    'rain': Symbols.rainy,
    'snow': Symbols.weather_snowy,
    'thunderstorm': Symbols.thunderstorm,
    'fog': Symbols.foggy,
    'mist': Symbols.foggy,
  };

  @override
  Widget build(BuildContext context) {
    final icon = _iconMap[mainCondition.toLowerCase()] ?? Symbols.wb_sunny;
    return Icon(icon, color: color, size: 35);
  }
}
