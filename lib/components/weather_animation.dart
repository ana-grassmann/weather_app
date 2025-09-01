import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

//widget that shows a weather animation based on the main weather condition
class WeatherAnimation extends StatelessWidget {
  final String mainCondition;
  final double size;

  const WeatherAnimation({
    super.key,
    this.mainCondition = "Clear",
    this.size = 200,
  });

  //mapping of main weather conditions to corresponding animation files
  static const _animationMap = {
    'clear': 'assets/Clear.json',
    'clouds': 'assets/Clouds.json',
    'rain': 'assets/Rain.json',
    'snow': 'assets/Snow.json',
    'thunderstorm': 'assets/Thunderstorm.json',
  };

  @override
  Widget build(BuildContext context) {
    final animationPath =
        _animationMap[mainCondition.toLowerCase()] ?? 'assets/Clear.json';
    return Lottie.asset(
      animationPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
