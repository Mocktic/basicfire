import 'package:contact/screens/HomeScreen.dart';
import 'package:contact/widgets/backArrow.dart';
import 'package:contact/widgets/background.dart';
import 'package:contact/widgets/cupoTextButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import '../../main.dart';

class LoginEmail extends StatefulWidget {
  @override
  _LoginEmailState createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  TextEditingController _email = new TextEditingController();

  TextEditingController _pass = new TextEditingController();

  bool _isObscurePass = true;

  var _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorBackground,
        body: Stack(
          children: [
            Background(),
            Positioned(
              top: 1.h,
              child: BackArrow(),
            ),
            Positioned(
              top: 17.8.h,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 15.h,
                        width: 15.h,
                        child: Image.asset('assets/user.png'),
                      ),
                      Container(
                        child: Text(
                          'Login',
                          style: theme.text25boldPrimary,
                        ),
                      ),
                      SizedBox(height: 5.h),
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
                              elevation: 5,
                              shadowColor: Colors.black,
                              child: Container(
                                alignment: Alignment.center,
                                width: 83.5.w,
                                // margin: EdgeInsets.symmetric(horizontal: 6.w),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 0.25.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  color: Colors.grey[300],
                                ),
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
                                    prefixIcon: Icon(Icons.email_outlined),
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
                              elevation: 5,
                              shadowColor: Colors.black,
                              child: Container(
                                width: 83.5.w,
                                // margin: EdgeInsets.symmetric(horizontal: 6.w),
                                padding: EdgeInsets.symmetric(
                                  vertical: 0.25.h,
                                  horizontal: 2.w,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  color: Colors.grey[300],
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
                                          prefixIcon: Icon(Icons.lock),
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
                          ],
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Container(
                        width: 95.w,
                        padding: EdgeInsets.only(right: 7.w),
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(fontSize: 10.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.5.h),
                      _isLoading
                          ? SpinKitThreeBounce(
                              color: theme.colorPrimary,
                              size: 15,
                            )
                          : CupoTextButton(
                              name: 'Next',
                              onTapped: () async {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                try {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: _email.text.trim(),
                                          password: _pass.text);
                                  Navigator.of(context).pushReplacement(
                                      CupertinoPageRoute(builder: (context) {
                                    return HomeScreen();
                                  }));
                                  setState(() {
                                    _isLoading = false;
                                  });
                                } catch (e) {
                                  print(e);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Something went wrong");
                                }
                              },
                            ),
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
