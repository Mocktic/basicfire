import 'package:contact/authentication/login/Otp_verification_Screen.dart';
import 'package:contact/main.dart';
import 'package:contact/widgets/background2.dart';
import 'package:contact/widgets/cupoTextButton.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class LoginPhoneScreen extends StatefulWidget {
  @override
  _LoginPhoneScreenState createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  String inital = "+91";
  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Background2(),
            Positioned(
              top: 4.5.h,
              child: Container(
                margin: EdgeInsets.only(left: 35),
                //color: Colors.grey,
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Container(
                      height: 25.h,
                      child: Center(
                        child: Lottie.asset(
                          'assets/OTPverify.json',
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      child: Text(
                        'What\'s your number?',
                        style: theme.text25boldPrimary,
                      ),
                    ),
                    SizedBox(height: 5.h),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 20.w,
                            height: 14.w,
                            decoration: BoxDecoration(
                              color: theme.colorGrey,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                            ),
                            child: FittedBox(
                              child: CountryCodePicker(
                                showDropDownButton: false,
                                initialSelection: 'IN',
                                showFlagMain: false,
                                textStyle: theme.text16Primary,
                                showCountryOnly: true,
                                onChanged: (contry) {
                                  inital = contry.dialCode;
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 14.w,
                            width: 2,
                            color: Colors.black26,
                          ),
                          Container(
                            width: 60.w,
                            height: 14.w,
                            //padding: EdgeInsets.symmetric(horizontal: 15),
                            child: CupertinoTextField(
                              controller: phoneController,
                              decoration: BoxDecoration(
                                color: theme.colorGrey,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(22),
                                  bottomRight: Radius.circular(22),
                                ),
                              ),
                              autofocus: true,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.phone,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 14),
                              style: theme.text20boldPrimary,
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    CupoTextButton(
                        name: 'Next',
                        onTapped: () {
                          Navigator.of(context)
                              .push(CupertinoPageRoute(builder: (context) {
                            return OtpVerificationScreen(
                              phoneno: (inital + phoneController.text.trim()),
                            );
                          }));
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
