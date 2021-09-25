import 'package:contact/authentication/SignUp/SignUpEmail.dart';
import 'package:contact/main.dart';
import 'package:contact/widgets/TimelineWidget.dart';
import 'package:contact/widgets/background2.dart';
import 'package:contact/widgets/cupoTextButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SignUpName extends StatefulWidget {
  @override
  _SignUpNameState createState() => _SignUpNameState();
}

class _SignUpNameState extends State<SignUpName> {
  TextEditingController _firstName = new TextEditingController();
  TextEditingController _lasttName = new TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.colorBackground,
        body: Stack(
          children: [
            Background2(),
            Positioned(
              top: 11.h,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: 50.w,
                        height: 140,
                        child: timelineWidget(
                          currentIndex: 0,
                          con: context,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        child: Text(
                          'What\'s your name?',
                          style: theme.text25boldPrimary,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                        elevation: 8,
                        shadowColor: Colors.black,
                        child: Container(
                          // alignment: Alignment.centerLeft,
                          // margin: EdgeInsets.symmetric(horizontal: 4.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.5.w, vertical: 0.25.h),
                          // height: 7.h,
                          //color: Colors.red,
                          width: 87.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: theme.colorGrey,
                          ),
                          child: TextFormField(
                            controller: _firstName,
                            style: theme.text16Primary,
                            validator: (value) {
                              if (value.isEmpty)
                                return 'This field cannot be empty!';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onSaved: (value) {
                              print(value);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        // alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        width: 87.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.5.w, vertical: 0.25.h),
                        // height: 7.h,
                        //color: Colors.red,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: theme.colorGrey,
                        ),
                        child: TextFormField(
                          controller: _lasttName,
                          style: theme.text16Primary,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'This field cannot be empty!';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onSaved: (value) {
                            print(value);
                          },
                        ),
                      ),
                      SizedBox(height: 12.h),
                      CupoTextButton(
                          name: 'Next',
                          onTapped: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            FirebaseDatabase.instance
                                .reference()
                                .child("User Information")
                                .child(FirebaseAuth.instance.currentUser.uid)
                                .update({
                              "First Name": _firstName.text.trim(),
                              "Last Name": _lasttName.text.trim()
                            });
                            Navigator.of(context).push(
                              CupertinoPageRoute(builder: (context) {
                                return SignUpEmail();
                              }),
                            );
                          })
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
