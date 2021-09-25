import 'package:contact/screens/addAgentScreen.dart';

class AgentsModel {
  String userId;
  String name;
  String email;
  bool isChecked;
  String phone;
  String photoUrl;
  DateTime createdDate;
  Gender gender;

  AgentsModel({
    this.userId,
    this.name,
    this.email,
    this.isChecked = false,
    this.phone,
    this.photoUrl,
    this.createdDate,
    this.gender,
  });
}
