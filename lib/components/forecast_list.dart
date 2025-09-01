import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/components/translucent_container.dart';
import 'package:weather_app/components/weather_icon.dart';
import 'package:weather_app/models/forecast_model.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ForecastList extends StatelessWidget {
  final List<Forecast>? forecasts;

  //define width percentages for each column (so the columns are aligned in every row):
  static const double _datePct = 0.10;
  static const double _dayPct = 0.14;
  static const double _conditionPct = 0.24;
  static const double _minTempPct = 0.24;
  static const double _maxTempPct = 0.24;
  static const EdgeInsets _boxPadding = EdgeInsets.all(14.0);

  const ForecastList({super.key, required this.forecasts});

  @override
  Widget build(BuildContext context) {
    //checking for null or empty list to avoid errors
    if (forecasts == null || forecasts!.isEmpty) {
      return const Center(child: Text('No forecast data'));
    }

    return Container(
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (context, constraints) {
          //calculating usable width inside the box after padding
          final usableWidth =
              constraints.maxWidth - (_boxPadding.left + _boxPadding.right);

          return ListView.builder(
            shrinkWrap: true,
            itemCount: forecasts!.length,
            //render each forecast item
            itemBuilder: (context, index) {
              final day = forecasts![index];
              return TranslucentContainer(
                padding: _boxPadding,
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    //day of month
                    SizedBox(
                      width: usableWidth * _datePct,
                      child: Text(
                        DateFormat.d().format(day.dateTime),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    //day of week
                    SizedBox(
                      width: usableWidth * _dayPct,
                      child: Text(
                        DateFormat.E().format(day.dateTime),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    //weather icon
                    SizedBox(
                      width: usableWidth * _conditionPct,
                      child: WeatherIcon(mainCondition: day.mainCondition),
                    ),
                    //min temperature
                    _TempColumn(
                      width: usableWidth * _minTempPct,
                      icon: Symbols.thermostat_arrow_down,
                      temp: day.minTemp.round(),
                    ),
                    //max temperature
                    _TempColumn(
                      width: usableWidth * _maxTempPct,
                      icon: Symbols.thermostat_arrow_up,
                      temp: day.maxTemp.round(),
                      iconAtEnd: true,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// A helper widget to display temperature with an icon
class _TempColumn extends StatelessWidget {
  final double width;
  final IconData icon;
  final int temp;
  final bool iconAtEnd;

  const _TempColumn({
    required this.width,
    required this.icon,
    required this.temp,
    this.iconAtEnd = false,
  });

  @override
  Widget build(BuildContext context) {
    final tempText = Text(
      "$temp°",
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      textAlign: TextAlign.center,
    );
    final tempIcon = Icon(icon, color: Colors.white, size: 20);

    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: iconAtEnd ? [tempText, tempIcon] : [tempIcon, tempText],
      ),
    );
  }
}
