import 'package:contact/authentication/SignUp/SignUp3.dart';
import 'package:contact/widgets/TimelineWidget.dart';
import 'package:contact/widgets/background2.dart';
import 'package:contact/widgets/cupoTextButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import '../../main.dart';

class SignUpEmail extends StatefulWidget {
  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  TextEditingController _email = new TextEditingController();

  TextEditingController _pass = new TextEditingController();

  TextEditingController _confirmpass = new TextEditingController();

  bool _isObscurePass = true;

  bool _isObscureConfirmPass = true;
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
              top: 4.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // BackArrow(),
                    SizedBox(height: 5.h),
                    Container(
                      width: 50.w,
                      height: 140,
                      child: timelineWidget(
                        currentIndex: 1,
                        con: context,
                      ),
                    ),
                    Container(
                      child: Text(
                        'Enter your email',
                        style: theme.text25boldPrimary,
                      ),
                    ),
                    SizedBox(height: 5.5.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.5.w, vertical: 0.25.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: theme.colorGrey,
                              ),
                              width: 90.w,
                              child: TextFormField(
                                controller: _email,
                                style: theme.text16Primary,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'This field cannot be empty!';
                                  else if (!value.contains('@'))
                                    return 'Enter a valid email address!';
                                  else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Email Address',
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                onSaved: (value) {
                                  print(value);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 4.h),
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
                              width: 90.w,
                              padding: EdgeInsets.only(
                                left: 5.5.w,
                                top: 0.25.h,
                                bottom: 0.25.h,
                              ),

                              // height: 7.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: theme.colorGrey,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 60.w,
                                    child: TextFormField(
                                      obscureText: _isObscurePass,
                                      controller: _pass,
                                      style: theme.text16Primary,
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return 'This field cannot be empty!';
                                        else if (value.length < 7)
                                          return 'Enter at least 7 character long password!';
                                        else
                                          return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      onSaved: (value) {
                                        print(value);
                                      },
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _isObscurePass = !_isObscurePass;
                                      });
                                    },
                                    child: _isObscurePass
                                        ? Icon(Icons.visibility_off_sharp)
                                        : Icon(Icons.visibility),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            width: 90.w,
                            margin: EdgeInsets.only(
                              right: 6.w,
                              left: 5.w,
                            ),
                            padding: EdgeInsets.only(
                              left: 5.5.w,
                              top: 0.25.h,
                              bottom: 0.25.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: theme.colorGrey,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 60.w,
                                  child: TextFormField(
                                    obscureText: _isObscureConfirmPass,
                                    controller: _confirmpass,
                                    style: theme.text16Primary,
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return 'This field cannot be empty!';
                                      else if (_pass.text != value)
                                        return 'Password do not match';
                                      else
                                        return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Confirm Password',
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                    onSaved: (value) {
                                      print(value);
                                    },
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscureConfirmPass =
                                          !_isObscureConfirmPass;
                                    });
                                  },
                                  child: _isObscureConfirmPass
                                      ? Icon(Icons.visibility_off_sharp)
                                      : Icon(Icons.visibility),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 7.5.h),
                    CupoTextButton(
                        name: 'Next',
                        onTapped: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          if (!(_pass.text == _confirmpass.text)) {
                            Fluttertoast.showToast(
                                msg: "enter correct password");
                            return;
                          }
                          FirebaseAuth.instance.currentUser
                              .updateEmail(_email.text.trim());
                          FirebaseAuth.instance.currentUser
                              .updatePassword(_pass.text);
                          FirebaseDatabase.instance
                              .reference()
                              .child("User Information")
                              .child(FirebaseAuth.instance.currentUser.uid)
                              .update({"Email": _email.text.trim()});
                          Navigator.of(context).push(
                            CupertinoPageRoute(builder: (context) {
                              return SignUp3();
                            }),
                          );
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
