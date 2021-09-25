import 'package:contact/Config/Enum/userTypes.dart';

class UserModel {
  String firstName, lastName, uid, phoneNumber, gender, photoURL, email;
  UsersType userType;
  UserModel({
    this.firstName,
    this.gender,
    this.lastName,
    this.phoneNumber,
    this.uid,
    this.userType,
    this.photoURL,
    this.email,
  });
}
