//import 'dart:js';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:contact/main.dart';
import 'package:contact/payment%20handling/paypalpayment.dart';
import 'package:contact/screens/DrawerScreen.dart';
import 'package:contact/widgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';
import 'package:hexcolor/hexcolor.dart';

class Websitepackage extends StatelessWidget {
  //List<Widget> carouselItems = ;
  void paymentButton(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaypalPayment(
          onFinish: (number) async {
            // payment done
            print(number);
            print("----------------------------------------");
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorBackground,
      appBar: customAppBar(context),
      body: Container(
        // color: Colors.yellow,
        margin: EdgeInsets.symmetric(vertical: 2.h),
        height: 87.h,
        child: CarouselSlider(
          options: CarouselOptions(
            //autoPlay: true,
            autoPlayCurve: Curves.slowMiddle,
            initialPage: 1,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            height: 92.h,
          ),
          items: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: HexColor('#fe4c8a'), width: 4),
                ),
                //  borderRadius: BorderRadius.circular(20),
                color: theme.colorBackground,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    'WEB DEVELOPMENT',
                    style: TextStyle(
                      color: HexColor('#fe4c8a'),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '1-2 week',
                    style: TextStyle(
                      color: theme.colorPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 45,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Html, css, javascript',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Github Code',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '3 Meeting',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '2 Revision',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Bug Fix',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: HexColor('#fe4c8a'),
                        padding: EdgeInsets.symmetric(
                            vertical: 2.5.h, horizontal: 4.w)),
                    onPressed: () {
                      paymentButton(context);
                    },
                    child: Text(
                      'ENQUIRE NOW',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              //color: Colors.red,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    HexColor('#f894b7'),
                    HexColor('#d0f08a'),
                  ],
                ),
                //borderRadius: BorderRadius.circular(20),
                // color: Colors.green,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    'PYTHON DEVELOPMENT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '2-3 week',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 45,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Django, Flask, Raw Python',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Github Code',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '6 Meeting',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '4 Revision',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Bug Fix',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 2.5.h, horizontal: 4.w)),
                    onPressed: () {
                      paymentButton(context);
                    },
                    child: Text(
                      'ENQUIRE NOW',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: HexColor('#fe4c8a')),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: theme.colorBackground,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                border: Border.symmetric(
                  horizontal: BorderSide(color: HexColor('#fe4c8a'), width: 4),
                ),
                //borderRadius: BorderRadius.circular(20),
                //color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    'APP DEVELOPMENT',
                    style: TextStyle(
                      color: HexColor('#fe4c8a'),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '3-6 week',
                    style: TextStyle(
                      color: theme.colorPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 45,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Flutter, Android Studio',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Github Code',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '6 Meeting',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '2 Revision',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Bug Fix',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        onSurface: Colors.black,

                        //enabledMouseCursor: MouseCursor.defer,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: HexColor('#fe4c8a'),
                        padding: EdgeInsets.symmetric(
                            vertical: 2.5.h, horizontal: 4.w)),
                    onPressed: () {
                      paymentButton(context);
                    },
                    child: Text(
                      'ENQUIRE NOW',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: DrawerScreen(),
    );
  }
}
