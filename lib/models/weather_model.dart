class Weather {
  final double lat;
  final double lon;
  final DateTime dateTime;
  final double temperature;
  final double tempFeel;
  final String mainCondition;

  Weather({
    required this.lat,
    required this.lon,
    required this.dateTime,
    required this.temperature,
    required this.tempFeel,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> jsonResponse) {
    //check https://openweathermap.org/api/one-call-3
    return Weather(
      lat: jsonResponse['lat'],
      lon: jsonResponse['lon'],
      dateTime: DateTime.fromMicrosecondsSinceEpoch(jsonResponse['current']['dt']),
      temperature: jsonResponse['current']['temp'].toDouble(),
      tempFeel: jsonResponse['current']['feels_like'].toDouble(),
      mainCondition: jsonResponse['current']['weather']['main'],
    );
  }
}
