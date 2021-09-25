String PmOrAm(String time) {
  if (time == null) {
    return "00:00";
  }
  final data = time.split(":");
  var val = int.parse(data[0]);
  var min = int.parse(data[1]);
  var pmORAm = "AM";
  if (val > 12) {
    val = val - 12;
    pmORAm = "PM";
  } else if (val == 0) {
    val = val + 12;
  } else if (val == 12) {
    pmORAm = "PM";
  }
  String zero;
  String aZero;
  val < 12
      ? val > 9
          ? zero = ""
          : zero = ""
      : zero = "";
  min < 10 ? aZero = "0" : aZero = "";
  return "$zero$val:$aZero${data[1]} $pmORAm";
}
