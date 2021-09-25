import 'package:contact/Config/Enum/Priority.dart';

class TaskModel {
  String taskName;
  DateTime dueDate;
  DateTime assignedDate;
  bool isCompleted;
  Map assignIDs;
  WorkPriority priority;
  String description;
  Map attachmentsLink;
  String id;
  String sectionID;
  // ignore: non_constant_identifier_names
  String SectionName;
  TaskModel({
    this.assignIDs,
    this.attachmentsLink,
    this.description,
    this.dueDate,
    this.isCompleted,
    this.priority,
    this.taskName,
    this.id,
    this.sectionID,
    this.assignedDate,
    // ignore: non_constant_identifier_names
    this.SectionName,
  });
}
