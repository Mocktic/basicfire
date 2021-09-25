import 'package:contact/authentication/login/loginEmail.dart';
import 'package:contact/authentication/login/loginPhoneScreen.dart';
import 'package:contact/main.dart';
import 'package:contact/widgets/back_2.dart';
import 'package:contact/widgets/cupoTextButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class LoginHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: HexColor("#212f45"),
      body: Stack(
        children: [
          Back2(),
          Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 5.h),
                  Image.asset(
                    'assets/LOGO USE THIS.png',
                    width: 80.w,
                    height: 80.w,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Hello!',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 13.h),
                  CupoTextButton(
                    name: 'Get Start',
                    onTapped: () {
                      Navigator.of(context)
                          .push(CupertinoPageRoute(builder: (context) {
                        return LoginPhoneScreen();
                      }));
                    },
                  ),
                  SizedBox(height: 2.h),
                  CupoTextButton(
                    name: 'Log In',
                    onTapped: () {
                      Navigator.of(context)
                          .push(CupertinoPageRoute(builder: (context) {
                        return LoginEmail();
                      }));
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
