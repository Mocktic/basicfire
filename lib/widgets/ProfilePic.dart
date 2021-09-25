import 'package:contact/Provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

class ProfilePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Center(
      child: user == null || user.photoURL == null
          ? CircleAvatar(
              radius: 5.h,
              backgroundColor: theme.colorBackground,
              child: Center(
                child: Text(
                  user != null ? user.firstName[0].toUpperCase() : "U",
                  style: theme.text20boldPrimary,
                ),
              ),
            )
          : CircleAvatar(
              radius: 5.h,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                user.photoURL,
              ),
            ),
    );
  }
}
