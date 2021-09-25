import 'package:contact/main.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PieChart extends StatefulWidget {
  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  @override
  Widget build(BuildContext context) {
    var a = 45;
    var b = 100;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 50.w,
      width: 50.w,
      child: Card(
        shadowColor: theme.colorPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: theme.darkMode ? Colors.grey[900] : theme.colorBackground,
        elevation: 5,
        child: CircularPercentIndicator(
          radius: 42.w,
          animation: true,
          animationDuration: 1000,
          lineWidth: 35,
          percent: a / b,
          center: Text(
            '${(a / b) * 100}%',
            style: theme.text20boldPrimary,
          ),
          progressColor: theme.addedColor,
          backgroundColor: theme.colorPrimary,
          circularStrokeCap: CircularStrokeCap.butt,
        ),
      ),
    );
  }
}
