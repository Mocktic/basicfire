import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

Future<List<Map<String, dynamic>>> excelToJson(
  String fileName,
  String fileDirectory,
  File file,
) async {
  // ByteData data = await rootBundle.load(fileDirectory);
  Uint8List bytes = file.readAsBytesSync();
  // data = ByteData.view(bytes.buffer);
  // var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);
  int i = 0;
  List<dynamic> keys = new List<dynamic>();
  List<Map<String, dynamic>> json = new List<Map<String, dynamic>>();
  for (var table in excel.tables.keys) {
    for (var row in excel.tables[table].rows) {
      if (i == 0) {
        keys = row;
        i++;
      } else {
        Map<String, dynamic> temp = Map<String, dynamic>();
        int j = 0;
        String tk = '';
        for (var key in keys) {
          tk = '"' + "$key" + '"';
          temp[tk] = (row[j].runtimeType == String)
              ? '"' + row[j].toString() + '"'
              : row[j];
          j++;
        }
        json.add(temp);
      }
    }
  }
  return json;
  // checks = newList;

  // checks.fillRange(0, 10, false);
}

Future<void> jsonToExcel(
  String fileName,
  String fileDirectory,
) async {
  String jsonString = await rootBundle.loadString(fileDirectory);

  List<dynamic> jsonResult = jsonDecode(jsonString)["DATA"];

  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Sheet1'];

  Map<String, dynamic> result = jsonResult[0];
  sheetObject.appendRow(result.keys.toList());

  for (int i = 0; i < jsonResult.length; i++) {
    Map<String, dynamic> result = jsonResult[i];
    sheetObject.appendRow(result.values.toList());
  }
  final directory = await getExternalStorageDirectory();

  final data = excel.encode();
  File(("${directory.path}/$fileName.xlsx"))
    ..createSync(recursive: true)
    ..writeAsBytesSync(data);

  print(sheetObject);
}
