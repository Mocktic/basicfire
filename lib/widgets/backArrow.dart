import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../main.dart';

class BackArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 5.w),
      alignment: Alignment.centerLeft,
      // color: (colorBackground == null)
      //     ? theme.colorBackground
      //     : theme.colorPrimary,
      height: 5.h,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back_ios_sharp,
          size: 25,
          color: theme.colorPrimary,
          // colorBackground == null
          //     ?
          //     : theme.colorBackground,
        ),
      ),
    );
  }
}
