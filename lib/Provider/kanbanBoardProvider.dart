import 'dart:io';
import 'package:contact/Config/Enum/Priority.dart';
import 'package:contact/Models/SectionModel.dart';
import 'package:contact/Models/TaskModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class KanbanBoardProvider with ChangeNotifier {
  List<Sectionmodel> _sections = [];
  List<TaskModel> _tasks = [];
  List<Sectionmodel> get sections {
    return [..._sections];
  }

  List<TaskModel> get tasks {
    return [..._tasks];
  }

  Map<Sectionmodel, List<TaskModel>> _map = {};
  Map<Sectionmodel, List<TaskModel>> get convertedData {
    return {..._map};
  }

  Future<void> addSection(Sectionmodel model) async {
    try {
      final key = FirebaseDatabase.instance
          .reference()
          .child("section")
          .child(FirebaseAuth.instance.currentUser.uid)
          .push()
          .key;
      FirebaseDatabase.instance
          .reference()
          .child("section")
          .child(FirebaseAuth.instance.currentUser.uid)
          .child(key)
          .update({
        "Name": model.Name,
        "dateCreated": DateTime.now().toIso8601String()
      });
      _sections.add(Sectionmodel(Name: model.Name, id: key));
      notifyListeners();
    } catch (e) {
      print(e);
      print("-------------errror is here--------------");
    }
  }

  Future<void> deleteSection(Sectionmodel model) async {
    try {
      FirebaseDatabase.instance
          .reference()
          .child("section")
          .child(FirebaseAuth.instance.currentUser.uid)
          .child(model.id)
          .remove();
      notifyListeners();
    } catch (e) {
      print(e);
      print("-------------errror is here--------------");
    }
  }

  Future<void> allSections() async {
    try {
      _sections = [];
      final datasnapshot = await FirebaseDatabase.instance
          .reference()
          .child("section")
          .child(FirebaseAuth.instance.currentUser.uid)
          .once();
      final data = datasnapshot.value as Map;
      if (data != null) {
        data.forEach((key, value) {
          _sections.add(Sectionmodel(
            Name: value['Name'],
            id: key,
          ));
        });
      }

      notifyListeners();
    } catch (e) {
      print(e);
      print("-------------errror is here--------------");
    }
  }

  Future<void> addNewTask(
      String title,
      String description,
      Map assignTo,
      WorkPriority priority,
      DateTime dueDate,
      // ignore: non_constant_identifier_names
      Sectionmodel Section) async {
    final key = FirebaseDatabase.instance
        .reference()
        .child("Tasks")
        .child(FirebaseAuth.instance.currentUser.uid)
        .push()
        .key;
    FirebaseDatabase.instance
        .reference()
        .child("Tasks")
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(key)
        .update({
      'title': title,
      'description': description,
      'Assign To': assignTo,
      "Due Date": dueDate.toIso8601String(),
      "Priority": priority.index,
      "Section": Section.Name,
      "sectionID": Section.id,
      "assignDate": DateTime.now().toIso8601String(),
    });
    _tasks.add(TaskModel(
      SectionName: Section.Name,
      assignIDs: assignTo,
      assignedDate: DateTime.now(),
      attachmentsLink: null,
      description: description,
      dueDate: dueDate,
      id: key,
      isCompleted: false,
      priority: priority,
      sectionID: Section.id,
      taskName: title,
    ));
    notifyListeners();
  }

  Future<void> attachNewDocs(File doc, TaskModel taskModel) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child("Task Files")
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(DateTime.now().toIso8601String());
    final url = await ref.getDownloadURL();
    Map<String, String> _map = {};
    _map.addAll(taskModel.attachmentsLink);
    _map.putIfAbsent(DateTime.now().toIso8601String(), () => url);
    FirebaseDatabase.instance
        .reference()
        .child("Tasks")
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(taskModel.id)
        .update({"Attachments": _map});
  }

  Future<void> allTasks(DateTime date) async {
    _tasks = [];
    final snapshot = await FirebaseDatabase.instance
        .reference()
        .child("Tasks")
        .child(FirebaseAuth.instance.currentUser.uid)
        .once();
    final data = snapshot.value as Map;
    if (data != null) {
      data.forEach((key, value) {
        _tasks.add(TaskModel(
            assignIDs: value,
            assignedDate: value['assignDate'] == null
                ? DateTime.now()
                : DateTime.parse(value['assignDate']),
            attachmentsLink: value['Attachments'],
            description: value['description'],
            dueDate: DateTime.parse(value['Due Date']),
            id: key,
            isCompleted:
                value['isCompleted'] == null ? false : value['isCompleted'],
            priority: value['Priority'] == 0
                ? WorkPriority.Low
                : value['Priority'] == 1
                    ? WorkPriority.Medium
                    : WorkPriority.High,
            sectionID: value['sectionID'],
            taskName: value['title'],
            SectionName: value['Section']));
      });
    }
    notifyListeners();
  }

  void convertor() {
    _map = {};
    _sections.forEach((element) {
      List<TaskModel> newList = [];
      _tasks.forEach((eleme) {
        if (eleme.sectionID == element.id) {
          print("working------------");
          newList.add(eleme);
        }
      });

      _map.putIfAbsent(element, () => newList);
    });
  }

  Future<void> deleteTask(String key) async {
    FirebaseDatabase.instance
        .reference()
        .child("Tasks")
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(key)
        .remove();
    _tasks.removeWhere((element) => element.id == key);
    notifyListeners();
  }

  Future<void> updateTask(TaskModel model) async {
    final key = FirebaseDatabase.instance
        .reference()
        .child("Tasks")
        .child(FirebaseAuth.instance.currentUser.uid)
        .push()
        .key;
    FirebaseDatabase.instance
        .reference()
        .child("Tasks")
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(key)
        .update({
      'title': model.taskName,
      'description': model.description,
      'Assign To': model.assignIDs,
      "Due Date": model.dueDate.toIso8601String(),
      "Priority": model.priority.index,
      "Section": model.SectionName,
      "sectionID": model.sectionID,
      "UpdatedDate": DateTime.now().toIso8601String(),
    });
    final task = TaskModel(
      SectionName: model.SectionName,
      assignIDs: model.assignIDs,
      assignedDate: model.assignedDate,
      attachmentsLink: model.attachmentsLink,
      description: model.description,
      dueDate: model.dueDate,
      id: key,
      isCompleted: false,
      priority: model.priority,
      sectionID: model.sectionID,
      taskName: model.taskName,
    );
    final index = _tasks.indexWhere((element) => element.id == key);
    _tasks[index] = task;
    notifyListeners();
  }
}
