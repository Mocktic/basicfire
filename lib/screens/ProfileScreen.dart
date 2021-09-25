import 'package:contact/Provider/UserProvider.dart';
import 'package:contact/widgets/ProfileAppbar.dart';
import 'package:contact/widgets/ProfilePic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:contact/main.dart';
import '../widgets/Details.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      backgroundColor: theme.colorBackground,
      appBar: profileAppbar(context),
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
            Center(
              child: Icon(
                Icons.camera_alt_outlined,
                color: Color(0xffDADADA),
                size: 24.sp,
              ),
            ),
            Center(
              child: Container(
                width: 60.w,
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  "${user.firstName} ${user.lastName}",
                  overflow: TextOverflow.ellipsis,
                  style: theme.text20boldPrimary,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Details(),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}
