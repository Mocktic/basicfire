import 'package:contact/widgets/ProfilePic.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import '../main.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.black, size: 35),
    backgroundColor: Color(0xff232323),
    elevation: 3,
    shadowColor: theme.colorPrimary,
    leading: Builder(
      builder: (context) => IconButton(
          icon: (Icon(
            MdiIcons.formatAlignLeft,
            size: 20.sp,
            color: theme.colorCompanion,
          )),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          }),
    ),
    actions: [
      Container(
        padding: EdgeInsets.only(top: 10, bottom: 13),
        child: ProfilePic(),
      )
    ],
  );
}
