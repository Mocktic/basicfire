import 'package:contact/authentication/SignUp/SignUpName.dart';
import 'package:contact/authentication/login/otp_input.dart';
import 'package:contact/screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneno;

  OtpVerificationScreen({this.phoneno});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  bool isCodeSent = false;
  bool _isLoading = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _verificationId;
  PinDecoration _pinDecoration = UnderlineDecoration(
    enteredColor: theme.colorBackground,
    hintText: '123456',
    color: theme.colorBackground,
    hintTextStyle: TextStyle(
      color: theme.colorGrey,
      fontSize: 20,
    ),
    textStyle: theme.text20boldWhite,
  );
  TextEditingController _pinEditingController = TextEditingController();

  void _onformsubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: _pinEditingController.text);

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((UserCredential value) async {
      if (value.user != null) {
        setState(() {
          _isLoading = true;
        });

        final data = await FirebaseDatabase.instance
            .reference()
            .child("User Information")
            .child(value.user.uid)
            .once();
        if (data.value == null) {
          await FirebaseDatabase.instance
              .reference()
              .child("User Information")
              .child(value.user.uid)
              .update({
            'uid': value.user.uid,
            "Profile Completed": false,
            "phone": value.user.phoneNumber,
          });
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
            return SignUpName();
          }));
        } else {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
            return HomeScreen();
          }));
        }

        // Handle loogged in state

      } else {
        showToast("Error validating OTP, try again", Colors.red);
      }
    }).catchError((error) {
      showToast("Something went wrong", Colors.red);
    });
  }

  void showToast(message, Color color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((UserCredential value) async {
        if (value.user != null) {
          setState(() {
            _isLoading = true;
          });
          final data = await FirebaseDatabase.instance
              .reference()
              .child("User Information")
              .child(value.user.uid)
              .once();
          if (data.value == null) {
            await FirebaseDatabase.instance
                .reference()
                .child("User Information")
                .child(value.user.uid)
                .update({
              'uid': value.user.uid,
              "Profile Completed": false,
              "phone": value.user.phoneNumber,
            });
            setState(() {
              _isLoading = false;
            });
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
              return SignUpName();
            }));
          } else {
            setState(() {
              _isLoading = false;
            });
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
              return HomeScreen();
            }));
          }
          //.....
        } else {
          showToast("Error validating OTP, try again", Colors.red);
        }
      }).catchError((error) {
        print(error);
        showToast("Try again in sometime", Colors.red);
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showToast(authException.message, Colors.red);
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    //Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "${widget.phoneno}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  @override
  void initState() {
    _onVerifyCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorBackground,
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 26.h,
                      child: Center(
                        child: Lottie.asset(
                          'assets/OTPverify.json',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        color: theme.colorPrimary,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 7.h,
                            ),
                            Text(
                              'OTP Verification',
                              style: GoogleFonts.ptSans(
                                  textStyle: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                'Please enter verification code sent to your mobile',
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: PinInputTextField(
                                pinLength: 6,
                                decoration: _pinDecoration,
                                controller: _pinEditingController,
                                autoFocus: true,
                                textInputAction: TextInputAction.done,
                                onSubmit: (pin) {
                                  if (pin.length == 6) {
                                    _onformsubmitted();
                                  } else {
                                    showToast("Invalid OTP", Colors.red);
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            InkWell(
                              onTap: () {
                                if (_pinEditingController.text.length == 6) {
                                  _onformsubmitted();
                                } else {
                                  showToast("Invalid OTP", Colors.red);
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Container(
                                    color: theme.colorCompanion,
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: Center(
                                      child: _isLoading
                                          ? SpinKitThreeBounce(
                                              color: Colors.black,
                                              size: 20,
                                            )
                                          : Text(
                                              'Continue',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
