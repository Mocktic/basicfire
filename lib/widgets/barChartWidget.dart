import 'package:contact/Models/ChartModel.dart';
import 'package:contact/main.dart';
import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sizer/sizer.dart';

class BarChartWidget extends StatefulWidget {
  @override
  _BarChartWidgetState createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  static List<ChartModel> dummyBarData = [
    ChartModel('Mon', 320),
    ChartModel('Tue', 180),
    ChartModel('Wed', 700),
    ChartModel('Thu', 340),
    ChartModel('Fri', 520),
    ChartModel('Sat', 250),
    ChartModel('Sun', 300),
  ];

  var series = [
    charts.Series(
      id: 'Users',
      seriesColor: !theme.darkMode
          ? charts.Color(r: 35, g: 35, b: 35)
          : charts.Color(r: 225, g: 225, b: 225),
      domainFn: (ChartModel chartData, _) => chartData.name,
      measureFn: (ChartModel chartData, _) => chartData.val,
      data: dummyBarData,
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(theme.colorCompanion),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    var chart = charts.BarChart(
      series,
      animate: true,
      behaviors: [
        new charts.ChartTitle('WeekDay',
            titleStyleSpec: charts.TextStyleSpec(
              fontSize: 15,
              color: !theme.darkMode
                  ? charts.Color(r: 35, g: 35, b: 35)
                  : charts.Color(r: 225, g: 225, b: 225),
            ),
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        new charts.ChartTitle('Active Users',
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
      elevation: 5,
      shadowColor: theme.colorPrimary,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: theme.darkMode ? Colors.grey[900] : theme.colorBackground,
        ),
        padding: EdgeInsets.all(10),
        height: 26.h,
        child: chart,
      ),
    );
  }
}
