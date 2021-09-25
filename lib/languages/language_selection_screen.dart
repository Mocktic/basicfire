import 'package:contact/authentication/login/loginHomeScreen.dart';
import 'package:contact/widgets/cupoTextButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
// import '../provider/LanguageProvider.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  bool isGerman = true;
  bool isEnglish = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorBackground,
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  'Hello!',
                  style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 17.sp, color: theme.colorPrimary),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Please select your language',
                  style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 15.sp, color: theme.colorPrimary),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ListTile(
                  title: Text(
                    'Deutsche',
                    style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 13.sp, color: theme.colorPrimary),
                    ),
                  ),
                  trailing: CupertinoSwitch(
                      value: isGerman,
                      onChanged: (value) async {
                        setState(() {
                          isGerman = value;
                        });
                        isEnglish = !value;
                      }),
                ),
                SizedBox(
                  height: 2.h,
                ),
                ListTile(
                  title: Text(
                    'English',
                    style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontSize: 13.sp, color: theme.colorPrimary),
                    ),
                  ),
                  trailing: CupertinoSwitch(
                      value: isEnglish,
                      onChanged: (value) async {
                        setState(() {
                          isEnglish = value;
                        });
                        isGerman = !value;
                      }),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupoTextButton(
                        name: "Get Started",
                        onTapped: () {
                          // print(theme.darkMode);
                          Navigator.of(context)
                              .push(CupertinoPageRoute(builder: (context) {
                            return LoginHomeScreen();
                          }));
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
