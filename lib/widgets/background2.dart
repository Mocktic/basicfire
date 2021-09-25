import 'package:contact/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Background2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            right: -60,
            bottom: -45,
            child: CircleAvatar(
              backgroundColor: theme.addedMoreColor,
              radius: 100,
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
                    bottom: 100,
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
            left: -100,
            top: -135,
            child: CircleAvatar(
              backgroundColor: theme.colorCompanion3,
              radius: 200,
              child: Stack(
                children: [
                  Positioned(
                    top: 237,
                    right: 195,
                    child: CircleAvatar(
                      backgroundColor: //Colors.black,
                          theme.addedColor,
                      radius: 15,
                    ),
                  ),
                  Positioned(
                    top: 225,
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
        ],
      ),
    );
  }
}
