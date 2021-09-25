import 'package:contact/Models/AppointmentModel.dart';
import 'package:contact/main.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointmentCard;
  AppointmentCard(this.appointmentCard);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 3,
      ),
      width: 60.w,
      child: Card(
        shadowColor: theme.colorPrimary,
        color: theme.colorBackground,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          //color: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appointmentCard.title,
                    style: theme.text14boldPimary,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                MdiIcons.timer,
                                color: theme.colorCompanion4,
                              ),
                              SizedBox(width: 2.w),
                              Text(appointmentCard.time,
                                  style: theme.text12Primary),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Container(
                        alignment: Alignment.center,
                        width: 110,
                        child: FittedBox(
                          child: Text(appointmentCard.name,
                              overflow: TextOverflow.ellipsis,
                              style: theme.text12Primary),
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 7.w),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: theme.colorPrimary,
                    child: Text('A'),
                  )
                ],
              ),
              Text(appointmentCard.email,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: theme.text12Primary),
              Text(
                appointmentCard.phone,
                style: theme.text12Primary,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
