import 'package:contact/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print(1.h / 1);
    return Scaffold(
      body: Stack(children: [
        Positioned(
          right: -10.w,
          top: -3.6.h,
          child: CircleAvatar(
            backgroundColor: theme.addedMoreColor,
            radius: 11.5.h,
          ),
        ),
        Positioned(
          left: -25.5.w,
          top: -17.h,
          child: CircleAvatar(
            backgroundColor: theme.colorCompanion3,
            radius: 23.5.h,
            child: Stack(
              children: [
                Positioned(
                  top: 28.4.h,
                  right: 49.6.w,
                  child: CircleAvatar(
                    backgroundColor: //Colors.black,
                        theme.addedColor,
                    radius: 1.8.h,
                  ),
                ),
                Positioned(
                  top: 27.h,
                  right: 28.w,
                  child: CircleAvatar(
                    backgroundColor: //Colors.black,
                        theme.addedColor,
                    radius: 3.h,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
