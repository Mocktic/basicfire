import 'package:contact/Provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import 'package:contact/main.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60.w,
          margin: EdgeInsets.only(top: 7.h, left: 7.w),
          child: Text(
            "First Name",
            overflow: TextOverflow.ellipsis,
            style: theme.text20boldPrimary,
          ),
        ),
        Card(
          elevation: 4,
          margin: EdgeInsets.only(top: 1.5.h, left: 7.w, right: 7.w),
          child: Container(
            margin: EdgeInsets.only(
                top: 1.75.h, left: 4.w, right: 7.w, bottom: 1.75.h),
            width: 100.w,
            child: Text(
              "${user.firstName == null ? "" : user.firstName}",
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xff9191AF),
              ),
            ),
          ),
        ),
        Container(
          width: 60.w,
          margin: EdgeInsets.only(top: 2.5.h, left: 7.w),
          child: Text(
            "Last Name",
            overflow: TextOverflow.ellipsis,
            style: theme.text20boldPrimary,
          ),
        ),
        Card(
          elevation: 4,
          margin: EdgeInsets.only(top: 1.5.h, left: 7.w, right: 7.w),
          child: Container(
            margin: EdgeInsets.only(
                top: 1.75.h, left: 4.w, right: 7.w, bottom: 1.75.h),
            width: 100.w,
            child: Text(
              "${user.lastName == null ? "" : user.lastName}",
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xff9191AF),
              ),
            ),
          ),
        ),
        Container(
          width: 60.w,
          margin: EdgeInsets.only(top: 2.5.h, left: 7.w),
          child: Text(
            "Gender",
            overflow: TextOverflow.ellipsis,
            style: theme.text20boldPrimary,
          ),
        ),
        Card(
          elevation: 4,
          margin: EdgeInsets.only(top: 1.5.h, left: 7.w, right: 7.w),
          child: Container(
            margin: EdgeInsets.only(
                top: 1.75.h, left: 4.w, right: 7.w, bottom: 1.75.h),
            width: 100.w,
            child: Text(
              "${user.gender == null ? "" : user.gender}",
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xff9191AF),
              ),
            ),
          ),
        ),
        Container(
          width: 60.w,
          margin: EdgeInsets.only(top: 2.5.h, left: 7.w),
          child: Text(
            "Mobile No",
            overflow: TextOverflow.ellipsis,
            style: theme.text20bold,
          ),
        ),
        Card(
          elevation: 4,
          margin: EdgeInsets.only(top: 1.5.h, left: 7.w, right: 7.w),
          child: Container(
            margin: EdgeInsets.only(
                top: 1.75.h, left: 4.w, right: 7.w, bottom: 1.75.h),
            width: 100.w,
            child: Text(
              "${user.phoneNumber}",
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xff9191AF),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
