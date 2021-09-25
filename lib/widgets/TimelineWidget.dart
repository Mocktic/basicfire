import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timelines/timelines.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

// ignore: camel_case_types
class timelineWidget extends StatelessWidget {
  final List<String> details = ["Name", "Email", "Gender"];
  final currentIndex;
  final BuildContext con;
  timelineWidget({this.currentIndex, this.con});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.w,
      child: Timeline.tileBuilder(
        theme: TimelineThemeData(
          direction: Axis.horizontal,
          indicatorTheme: IndicatorThemeData(
            color: theme.colorPrimary,
            size: 32,
          ),
          connectorTheme: ConnectorThemeData(
            color: Colors.black,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          //contentsAlign: ContentsAlign.alternating,
          indicatorBuilder: (context, index) => DotIndicator(
            child: currentIndex > index
                ? Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18,
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(color: theme.colorBackground),
                    ),
                  ),
          ),
          connectorBuilder: (context, index, type) => Connector.solidLine(),
          contentsBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '${details[index]}',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          itemCount: details.length,
        ),
      ),
    );
  }
}
