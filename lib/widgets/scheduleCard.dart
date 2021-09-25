import 'package:contact/Models/ScheduledTimeModel.dart';
import 'package:contact/widgets/addScheduleWidget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

class ScheduleScreenCard extends StatelessWidget {
  ScheduleScreenCard({
    this.scheduleContents,
  });

  final ScheduleModel scheduleContents;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: theme.colorBackground,
      //color: HexColor(scheduleContents.colorCode),
      elevation: 3,
      shadowColor: theme.colorPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        //color: Colors.blue,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(scheduleContents.title, style: theme.text18boldPrimary2),
            SizedBox(height: 1.5.h),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(text: 'Description:  ', style: theme.text16bold),
                TextSpan(
                    text: scheduleContents.description,
                    style: theme.text14primary)
              ])),
            ),
            SizedBox(height: 1.75.h),
            Row(
              children: [
                Text('Start:  ', style: theme.text14boldPimary),
                Icon(
                  MdiIcons.timer,
                  color: theme.colorCompanion4,
                ),
                Text(
                  "10:30",
                  style: theme.text14primary,
                ),
              ],
            ),
            SizedBox(height: 0.75.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('End:  ', style: theme.text14boldPimary),
                    Icon(
                      MdiIcons.timer,
                      color: theme.contrastColor,
                    ),
                    Text(
                      "12:30",
                      style: theme.text14primary,
                    ),
                  ],
                ),

                //SizedBox(width: 34.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: Icon(
                          MdiIcons.fileEdit,
                          color: theme.addedMoreColor,
                          size: 22.sp,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AddScheduleWidget(id: scheduleContents.id)));
                        }),
                    IconButton(
                        icon: Icon(
                          MdiIcons.delete,
                          color: theme.contrastColor,
                          size: 22.sp,
                        ),
                        onPressed: () {})
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
