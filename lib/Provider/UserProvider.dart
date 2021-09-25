import 'package:contact/Models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel user;

  void setCurrentUser(UserModel user) {
    this.user = user;
    notifyListeners();
  }

  Future<void> updateUser(UserModel user, BuildContext context) async {
    final ref = FirebaseDatabase.instance
        .reference()
        .child("User Information")
        .child(FirebaseAuth.instance.currentUser.uid);
    var userInfo = {
      "uid": user.uid,
      "First Name": user.firstName,
      "Last Name": user.lastName,
      "photoURL": user.photoURL,
      "phone": user.phoneNumber,
      "gender": user.gender,
    };
    await ref.update(userInfo);
    this.user = user;
    notifyListeners();
  }
}
