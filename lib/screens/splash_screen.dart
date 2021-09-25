import 'dart:async';

import 'package:contact/authentication/SignUp/SignUpName.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Screens/HomeScreen.dart';
import '../languages/language_selection_screen.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    getcurrentUser();
  }

  Future<void> getcurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Future.delayed(Duration(seconds: 2)).then((value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => LanguageSelectionScreen(),
          ),
        );
      });
      return;
    }
    if (user != null) {
      Future.delayed(Duration(seconds: 2)).then((value) async {
        final data = await FirebaseDatabase.instance
            .reference()
            .child("User Information")
            .child(user.uid)
            .once();
        if (data.value != null && data.value['Profile Completed']) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(),
            ),
          );
        } else {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => SignUpName(),
            ),
          );
        }
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#212f45"),
        body: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Container(
                height: 40.h,
                width: 80.w,
                child: Image.asset('assets/LOGO USE THIS.png'),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CircularProgressIndicator(backgroundColor: Colors.black)
          ],
        ),
      ),
    );
  }
}
