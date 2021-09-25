import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class EmailProvider with ChangeNotifier {
  Future<void> sendEmail(String subject, String body, List<String> mail) async {
    FirebaseFirestore.instance.collection("email").add(
      {
        "to": mail,
        "message": {
          "subject": "$subject",
          "text": "$body",
        },
      },
    );
  }
}
