import 'package:contact/Models/LineChartModel.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sizer/sizer.dart';

import '../main.dart';

class LineChartWidget extends StatefulWidget {
  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  static var linesUserData = [
    LineChartModel(1, 140),
    LineChartModel(2, 250),
    LineChartModel(3, 280),
    LineChartModel(4, 180),
    LineChartModel(5, 200),
    LineChartModel(6, 300),
    LineChartModel(7, 400),
    LineChartModel(8, 350),
    LineChartModel(9, 300),
    LineChartModel(10, 380),
    LineChartModel(11, 500),
    LineChartModel(12, 550),
  ];
  static var linesMailData = [
    LineChartModel(1, 1000),
    LineChartModel(2, 1500),
    LineChartModel(3, 2500),
    LineChartModel(4, 1300),
    LineChartModel(5, 2000),
    LineChartModel(6, 1800),
    LineChartModel(7, 2200),
    LineChartModel(8, 2380),
    LineChartModel(9, 1900),
    LineChartModel(10, 2600),
    LineChartModel(11, 2000),
    LineChartModel(12, 1700),
  ];
  List<charts.Series<LineChartModel, int>> graphSeries = [
    charts.Series(
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(theme.contrastColor),
      id: 'User Added',
      data: linesUserData,
      domainFn: (LineChartModel chartData, _) => chartData.monthVal,
      measureFn: (LineChartModel chartData, _) => chartData.val,
    ),
    charts.Series(
      colorFn: (__, _) => charts.ColorUtil.fromDartColor(theme.colorCompanion),
      id: 'Mails Sent',
      data: linesMailData,
      domainFn: (LineChartModel chartData, _) => chartData.monthVal,
      measureFn: (LineChartModel chartData, _) => chartData.val,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    var chart = charts.LineChart(
      graphSeries,
      animate: true,
      behaviors: [
        new charts.ChartTitle('Months',
            titleStyleSpec: charts.TextStyleSpec(
              fontSize: 15,
              color: !theme.darkMode
                  ? charts.Color(r: 35, g: 35, b: 35)
                  : charts.Color(r: 225, g: 225, b: 225),
            ),
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        new charts.ChartTitle('Users/Mails',
            titleStyleSpec: charts.TextStyleSpec(
              fontSize: 15,
              color: !theme.darkMode
                  ? charts.Color(r: 35, g: 35, b: 35)
                  : charts.Color(r: 225, g: 225, b: 225),
            ),
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
      ],
    );
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      shadowColor: theme.colorPrimary,
      color: theme.darkMode ? Colors.grey[900] : theme.colorBackground,
      child: Container(
        padding: EdgeInsets.all(10),
        height: 26.h,
        child: chart,
      ),
    );
  }
}
