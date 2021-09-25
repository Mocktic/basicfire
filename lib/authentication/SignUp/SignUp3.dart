import 'package:contact/screens/HomeScreen.dart';
import 'package:contact/widgets/TimelineWidget.dart';
import 'package:contact/widgets/background2.dart';
import 'package:contact/widgets/cupoTextButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';

class SignUp3 extends StatelessWidget {
  static String gender = "Male";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorBackground,
        body: Stack(
          children: [
            Background2(),
            Positioned(
              top: 10.5.h,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50.w,
                        height: 140,
                        child: timelineWidget(
                          currentIndex: 2,
                          con: context,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Center(
                        child: Text(
                          "What’s your Gender?",
                          style: theme.text25boldPrimary,
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      StatefulBuilder(
                        builder: (context, setGender) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  gender = "Male";
                                  setGender(() {});
                                },
                                child: CircleAvatar(
                                  radius: gender == "Male" ? 53.sp : 35.sp,
                                  backgroundColor: theme.colorPrimary,
                                  child: CircleAvatar(
                                    backgroundColor: theme.colorBackground,
                                    radius: gender == "Male" ? 50.sp : 33.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        "assets/male.svg",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 13.w,
                              ),
                              InkWell(
                                onTap: () {
                                  gender = "Female";
                                  setGender(() {});
                                },
                                child: CircleAvatar(
                                  radius: gender == "Female" ? 53.sp : 35.sp,
                                  backgroundColor: theme.colorPrimary,
                                  child: CircleAvatar(
                                    backgroundColor: theme.colorBackground,
                                    radius: gender == "Female" ? 50.sp : 33.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        "assets/female.svg",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CupoTextButton(
                          name: 'Next',
                          onTapped: () {
                            FirebaseDatabase.instance
                                .reference()
                                .child("User Information")
                                .child(FirebaseAuth.instance.currentUser.uid)
                                .update({
                              "gender": gender,
                              "Profile Completed": true,
                              "UserType": "Admin"
                            });
                            Navigator.of(context).pushAndRemoveUntil(
                                CupertinoPageRoute(builder: (context) {
                              return HomeScreen();
                            }), (route) => route.isFirst);
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
