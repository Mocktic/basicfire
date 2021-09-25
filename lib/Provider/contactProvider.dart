import 'package:contact/Models/ContactModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class ContactProvider with ChangeNotifier {
  List<ContactModel> _contacts = [];
  List<ContactModel> get contacts {
    return [..._contacts];
  }

  Future<void> fetchdetails() async {
    _contacts = [];
    final snap = await FirebaseDatabase.instance
        .reference()
        .child("Contacts")
        .child(FirebaseAuth.instance.currentUser.uid)
        .once();
    final mapped = snap.value as Map;
    if (mapped != null) {
      mapped.forEach((key, value) {
        _contacts.add(ContactModel(
          address: value['address'],
          companyName: value['company name'],
          email: value['email'],
          isSelected: false,
          name: value['Name'],
          phone: value['Contact no'],
          socialMediaLink: value['social media link'],
          id: key,
        ));
      });
      notifyListeners();
    }
  }

  decodeAddData(List<Map<String, dynamic>> data) {
    data.forEach((element) {
      Map<String, String> eachDecode = {};
      final keytoserver = FirebaseDatabase.instance
          .reference()
          .child("Contacts")
          .child(FirebaseAuth.instance.currentUser.uid)
          .push()
          .key;
      element.forEach((key, value) {
        final k = decodeData(key);
        final v = decodeData(value);
        eachDecode.putIfAbsent(k, () => v);
      });
      _contacts.add(ContactModel(
        address: eachDecode['address'],
        companyName: eachDecode['company name'],
        email: eachDecode['email'],
        isSelected: false,
        name: eachDecode['Name'],
        phone: eachDecode['Contact no'],
        socialMediaLink: eachDecode['social media link'],
        id: keytoserver,
      ));

      FirebaseDatabase.instance
          .reference()
          .child("Contacts")
          .child(FirebaseAuth.instance.currentUser.uid)
          .child(keytoserver)
          .update(eachDecode);
      notifyListeners();
    });
  }

  String decodeData(str) {
    final str1decode = str.toString().split("(");
    final str2decode = str1decode[1].split(",");
    return "" + str2decode[0];
  }

  Future<void> delete(str) async {
    await FirebaseDatabase.instance
        .reference()
        .child("Contacts")
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(str)
        .remove();
    _contacts.removeWhere((element) => element.id == str);
    notifyListeners();
  }
}
