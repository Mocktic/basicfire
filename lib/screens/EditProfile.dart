import 'package:contact/Provider/UserProvider.dart';
import 'package:contact/widgets/ProfilePic.dart';
import 'package:contact/widgets/UpdateProfilePic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';
import './HomeScreen.dart';

class EditProfile extends StatelessWidget {
  static List<String> genderList = [
    'Male',
    'Female',
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            ProfilePic(),
            SizedBox(
              height: 5,
            ),
            UpdateProfilePic(),
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
                  left: 4.w,
                  right: 7.w,
                ),
                width: 100.w,
                child: TextFormField(
                  initialValue:
                      "${user.firstName == null ? "" : user.firstName}",
                  onChanged: (value) {
                    user.firstName = value;
                  },
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                  keyboardType: TextInputType.text,
                  cursorColor: Color(0xff9191AF),
                  decoration: InputDecoration(
                    border: InputBorder.none,
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
                  left: 4.w,
                  right: 7.w,
                ),
                width: 100.w,
                child: TextFormField(
                  initialValue: "${user.lastName ?? ""}",
                  onChanged: (value) {
                    user.lastName = value;
                  },
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                  keyboardType: TextInputType.text,
                  cursorColor: Color(0xff9191AF),
                  decoration: InputDecoration(
                    border: InputBorder.none,
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
                  left: 4.w,
                  right: 7.w,
                ),
                width: 100.w,
                child: DropdownButtonFormField(
                  value: user.gender,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  items: genderList.map((e) {
                    return DropdownMenuItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: (value) {
                    user.gender = value.toString();
                  },
                ),
              ),
            ),
            Container(
              width: 60.w,
              margin: EdgeInsets.only(top: 2.5.h, left: 7.w),
              child: Text(
                "Mobile No",
                overflow: TextOverflow.ellipsis,
                style: theme.text20boldPrimary,
              ),
            ),
            Card(
              elevation: 4,
              margin: EdgeInsets.only(top: 1.5.h, left: 7.w, right: 7.w),
              child: Container(
                margin: EdgeInsets.only(
                  left: 4.w,
                  right: 7.w,
                ),
                width: 100.w,
                child: TextFormField(
                  enabled: false,
                  initialValue: "${user.phoneNumber}",
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                  keyboardType: TextInputType.text,
                  cursorColor: Color(0xff9191AF),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            InkWell(
              onTap: () async {
                await Provider.of<UserProvider>(context, listen: false)
                    .updateUser(user, context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                    (route) => false);
              },
              child: Center(
                child: Container(
                  width: 85.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: theme.colorPrimary,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                  alignment: Alignment.center,
                  child: Text(
                    "Save Profile",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(0xffF4F4F2),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}
