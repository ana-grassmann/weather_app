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
          final bigScreen = MediaQuery.of(context).size.width > 600;

          return Column(
            children: [
              //header row (only for bigger screens)
              if (bigScreen)
                Padding(
                  padding: _boxPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: usableWidth * _datePct,
                        child: _buildHeaderText(text: 'Day'),
                      ),
                      SizedBox(
                        width: usableWidth * _dayPct,
                        child: _buildHeaderText(text: 'Weekday'),
                      ),
                      SizedBox(
                        width: usableWidth * _conditionPct,
                        child: _buildHeaderText(text: 'Condition'),
                      ),
                      SizedBox(
                        width: usableWidth * _minTempPct,
                        child: _buildHeaderText(text: 'Min Temp'),
                      ),
                      SizedBox(
                        width: usableWidth * _maxTempPct,
                        child: _buildHeaderText(text: 'Max Temp'),
                      ),
                    ],
                  ),
                ),
              //List of forecast days
              ListView.builder(
                shrinkWrap: true,
                itemCount: forecasts!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final day = forecasts![index];
                  return TranslucentContainer(
                    padding: _boxPadding,
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              WeatherIcon(mainCondition: day.mainCondition),
                              if (bigScreen) ...[
                                const SizedBox(width: 8),
                                Text(
                                  day.mainCondition,
                                  style: TextStyle(
                                    fontSize: 18,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        //min temperature
                        SizedBox(
                          width: usableWidth * _minTempPct,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Symbols.thermostat_arrow_down,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${day.minTemp.round()}°",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        //max temperature
                        SizedBox(
                          width: usableWidth * _maxTempPct,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${day.maxTemp.round()}°",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Symbols.thermostat_arrow_up,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  // Helper method to build header text
  Widget _buildHeaderText({required String text}) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      textAlign: TextAlign.center,
    );
  }
}
