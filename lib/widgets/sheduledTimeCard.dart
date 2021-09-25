import 'package:contact/Models/ScheduledTimeModel.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

class ScheduleTimeCard extends StatelessWidget {
  final ScheduleModel scheduleCard;
  ScheduleTimeCard(this.scheduleCard);
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 3),
      width: 60.w,
      child: Card(
        color: theme.colorBackground,
        shadowColor: theme.colorPrimary,
        elevation: 4.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        // color: HexColor(scheduleCard.colorCode),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    scheduleCard.title,
                    style: theme.text14boldPimary,
                  ),
                ],
              ),
              Text(
                scheduleCard.description,
                style: theme.text12Primary,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              FittedBox(
                child: Row(
                  children: [
                    Icon(
                      MdiIcons.timer,
                      color: theme.colorCompanion4,
                    ),
                    Text(
                      "10:30 PM", style: theme.text12Primary,
                      // scheduleCard.start.toString()
                    ),
                  ],
                ),
              ),
              FittedBox(
                child: Row(
                  children: [
                    Icon(
                      MdiIcons.timer,
                      color: theme.contrastColor,
                    ),
                    Text(
                      "12:30 PM", style: theme.text12Primary,
                      // scheduleCard.end.toString()
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
