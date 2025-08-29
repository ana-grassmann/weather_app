import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/forecast_model.dart';

class ForecastList extends StatelessWidget {
  final List<Forecast>? forecasts;

  const ForecastList({super.key, required this.forecasts});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          for (var day in forecasts!)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat.d().format(day.dateTime), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 )),
                Text(DateFormat.E().format(day.dateTime), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 )),
                Text(day.mainCondition, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 )),
                Text("${day.minTemp.round()}°", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 )),
                Text("${day.maxTemp.round()}°", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 )),
              ],
            ),
        ],
      ),
    );
  }
}
