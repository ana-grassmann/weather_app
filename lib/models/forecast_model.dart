class Forecast {
  final DateTime dateTime;
  final String mainCondition;
  final double minTemp;
  final double maxTemp;

  Forecast({
    required this.dateTime,
    required this.mainCondition,
    required this.minTemp,
    required this.maxTemp,
  });

  //factory method to create a Forecast instance from JSON data returned by the API
  factory Forecast.fromJson(
    Map<String, dynamic> jsonResponse,
    int timezoneOffset,
  ) {
    //check https://openweathermap.org/forecast16
    return Forecast(
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        (jsonResponse['dt'] + timezoneOffset) * 1000,
        isUtc: true,
      ),
      mainCondition: jsonResponse['weather'][0]['main'],
      minTemp: jsonResponse['temp']['min'],
      maxTemp: jsonResponse['temp']['max'],
    );
  }
}
