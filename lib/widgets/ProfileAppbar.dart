import 'package:contact/screens/EditProfile.dart';
import 'package:contact/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:sizer/sizer.dart';

import 'package:contact/main.dart';

AppBar profileAppbar(BuildContext context) {
  return AppBar(
    elevation: 12,
    backgroundColor: Colors.white,
    leadingWidth: 16.w,
    titleSpacing: 1.w,
    title: Text(
      "Profile",
      style: theme.text14boldPimary,
    ),
    leading: IconButton(
      icon: (Icon(
        MdiIcons.arrowLeft,
        size: 17.sp,
      )),
      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => route.isFirst),
    ),
    iconTheme: IconThemeData(color: theme.colorCompanion),
    actionsIconTheme: IconThemeData(color: theme.colorPrimary),
    actions: [
      IconButton(
        // constraints: BoxConstraints(minWidth: 11.w),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EditProfile()));
        },
        icon: Icon(
          MdiIcons.imageEdit,
          size: 16.sp,
        ),
      ),
    ],
  );
}
