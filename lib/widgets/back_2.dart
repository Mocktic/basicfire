import 'package:contact/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class Back2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#212f45"),
      body: Stack(children: [
        Positioned(
          right: -50,
          top: -10,
          child: CircleAvatar(
            backgroundColor: theme.addedMoreColor,
            radius: 9.5.h,
            child: Stack(
              children: [
                Positioned(
                  right: 100,
                  bottom: 70,
                  child: CircleAvatar(
                    backgroundColor: //Colors.black,
                        theme.addedColor,
                    radius: 15,
                  ),
                ),
                Positioned(
                  right: 70,
                  top: 100,
                  child: CircleAvatar(
                    backgroundColor: //Colors.black,
                        theme.addedColor,
                    radius: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: -200,
          bottom: -135,
          child: CircleAvatar(
            backgroundColor: theme.colorCompanion3,
            radius: 200,
            child: Stack(
              children: [
                Positioned(
                  bottom: 200,
                  left: 50,
                  child: CircleAvatar(
                    backgroundColor: //Colors.black,
                        theme.addedColor,
                    radius: 15,
                  ),
                ),
                Positioned(
                  bottom: 200,
                  right: 110,
                  child: CircleAvatar(
                    backgroundColor: //Colors.black,
                        theme.addedColor,
                    radius: 25,
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
