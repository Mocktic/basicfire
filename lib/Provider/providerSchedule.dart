import 'package:contact/Models/ScheduledTimeModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class ScheduleProvider with ChangeNotifier {
  List<ScheduleModel> _scheduleList = [
    ScheduleModel(
        description:
            'ajifouaiof ayifha hahi fjhkah hkahuh ajhufh ahufh khiufhak ahiuf',
        start: DateTime.now(),
        end: DateTime.now(),
        id: '1',
        title: 'kjaiojfia'),
    ScheduleModel(
        description:
            'ajifouaiof ayifha hahi fjhkah hkahuh ajhufh ahufh khiufhak ahiuf',
        start: DateTime.now(),
        end: DateTime.now(),
        id: '1',
        title: 'kjaiojfia'),
    ScheduleModel(
        description:
            'ajifouaiof ayifha hahi fjhkah hkahuh ajhufh ahufh khiufhak ahiuf',
        start: DateTime.now(),
        end: DateTime.now(),
        id: '1',
        title: 'kjaiojfia'),
  ];

  List<ScheduleModel> get scheduleList {
    return [..._scheduleList];
  }

  Future<void> addSchedule(ScheduleModel model) async {
    try {
      final key =
          FirebaseDatabase.instance.reference().child("Schedules").push().key;
      FirebaseDatabase.instance
          .reference()
          .child("Schedules")
          .child(FirebaseAuth.instance.currentUser.uid)
          .child(key)
          .update({
        "Title": model.title,
        "description": model.description,
        "ColorCode": model.colorCode,
        "start time": model.start.toIso8601String(),
        "end time": model.end.toIso8601String(),
      });
      notifyListeners();
    } catch (e) {
      print(e);
      print("--------------error is here--------------");
    }
  }

  Future<void> allSchedules(DateTime date) async {
    try {
      _scheduleList = [];
      final datasnap = await FirebaseDatabase.instance
          .reference()
          .child("Schedules")
          .child(FirebaseAuth.instance.currentUser.uid)
          .orderByChild("start time")
          .equalTo(date.toIso8601String())
          .once();
      final data = datasnap.value as Map;
      if (data != null) {
        data.forEach((key, value) {
          _scheduleList.add(
            ScheduleModel(
              colorCode: value['ColorCode'],
              description: value['description'],
              end: DateTime.parse(value['end time']),
              id: key,
              start: DateTime.parse(value['start time']),
              title: value['Title'],
            ),
          );
        });
      }
      notifyListeners();
    } catch (e) {
      print(e);
      print("--------------error is here--------------");
    }
  }

  Future<void> deleteUser(String key) async {
    FirebaseDatabase.instance
        .reference()
        .child("Schedules")
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(key)
        .remove();
  }

  Future<void> updateUser(ScheduleModel model) async {
    try {
      await FirebaseDatabase.instance
          .reference()
          .child("Schedules")
          .child(FirebaseAuth.instance.currentUser.uid)
          .child(model.id)
          .update({
        "Title": model.title,
        "description": model.description,
        "ColorCode": model.colorCode,
        "start time": model.start.toIso8601String(),
        "end time": model.end.toIso8601String(),
      });
      notifyListeners();
    } catch (e) {
      print(e);
      print("--------------error is here--------------");
    }
  }
}
