class ScheduleModel {
  String id;
  String title;
  String description;
  DateTime start;
  DateTime end;
  String colorCode;

  ScheduleModel({
    this.id,
    this.title,
    this.colorCode = "#ffffff",
    this.description,
    this.end,
    this.start,
  });
}
