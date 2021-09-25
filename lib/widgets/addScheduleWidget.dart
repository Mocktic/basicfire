import 'package:contact/Config/Helper/PmorAmfx.dart';
import 'package:contact/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class AddScheduleWidget extends StatefulWidget {
  final String id;
  AddScheduleWidget({this.id});
  @override
  _AddScheduleWidgetState createState() => _AddScheduleWidgetState();
}

class _AddScheduleWidgetState extends State<AddScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _titleController = TextEditingController();
    final _descriptionController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: theme.colorPrimary,
          title: Text(
            'Add your Schedule',
            style: theme.text18bold,
            textAlign: TextAlign.center,
          ),
        ),
        body: Container(
          height: 82.h,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 3,
              colors: [theme.colorBackground, theme.addedColor],
            ),
          ),
          padding: EdgeInsets.only(
              right: 4.5.w, left: 4.5.w, top: 1.8.h, bottom: 1.h),
          child: Form(
            key: _formKey,
            child: Container(
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.4.h),
                    child: RichText(
                      text: TextSpan(
                          style: theme.text16bold,
                          text: 'Title',
                          children: [
                            TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red)),
                          ]),
                    ),
                  ),
                  Card(
                    //color: theme.colorBackground,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 13.sp,
                        //color: theme.colorPrimary,
                      ),
                      controller: _titleController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 3.w),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                      validator: (value) {
                        if (value.length == 0) {
                          return ('You can\'t leave this field empty');
                        }

                        return null;
                      },
                      // onSaved: (val) {
                      //   schedule = ScheduleModel(
                      //     id: schedule.id,
                      //     title: val,
                      //     start: schedule.start,
                      //     end: schedule.end,
                      //     description: schedule.description,
                      //   );
                      // },
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.4.h),
                    child: RichText(
                      text: TextSpan(
                          style: theme.text16bold,
                          text: 'Description',
                          children: [
                            TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red)),
                          ]),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      style: TextStyle(fontSize: 13.sp),
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 2.h),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value.length == 0) {
                          return ('You can\'t leave this field empty');
                        }
                        if (value.length < 20) {
                          return 'Add at least 20 character to description';
                        }
                        return null;
                      },
                      // onSaved: (val) {
                      //   schedule = ScheduleModel(
                      //     id: schedule.id,
                      //     title: schedule.title,
                      //     start: schedule.start,
                      //     end: schedule.end,
                      //     description: val,
                      //   );
                      // },
                    ),
                  ),
                  SizedBox(height: 1.7.h),
                  DateTimeWidget(),
                  SizedBox(height: 1.h),
                  ColorPickerWidget()
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            color: theme.addedColor,
            height: 8.h,
            width: double.infinity,
            child: Text(
              'Add Schedule',
              style: theme.text18boldPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class DateTimeWidget extends StatefulWidget {
  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  DateTime selectedDate = DateTime.now();

  TimeOfDay startSelectedTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay endSelectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context,
      TextEditingController controller, TimeOfDay selectedTime) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        var now = DateTime.now();
        var dt = DateTime(now.year, now.month, now.day, selectedTime.hour,
            selectedTime.minute);
        var formattedTime = DateFormat('HH:mm').format(dt);
        print(formattedTime);
        print(PmOrAm('${selectedTime.hour}:${selectedTime.minute}'));
        controller.text = PmOrAm('${selectedTime.hour}:${selectedTime.minute}');
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.4.h),
          child: RichText(
            text: TextSpan(
                style: theme.text16bold,
                text: 'Schedule Date',
                children: [
                  TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
                ]),
          ),
        ),
        InkWell(
          onTap: () {
            _selectDate(
              context,
            );
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: TextFormField(
              style: TextStyle(fontSize: 13.sp),
              enabled: false,
              keyboardType: TextInputType.text,
              controller: _dateController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(3.w),
                disabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.4.h),
          child: RichText(
            text: TextSpan(
                style: theme.text16bold,
                text: 'Starting Time',
                children: [
                  TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
                ]),
          ),
        ),
        InkWell(
          onTap: () {
            _selectTime(context, _startTimeController, startSelectedTime);
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: TextFormField(
              style: TextStyle(fontSize: 13.sp),
              enabled: false,
              keyboardType: TextInputType.text,
              controller: _startTimeController,
              decoration: InputDecoration(
                disabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.all(3.w),
              ),
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.4.h),
          child: RichText(
            text: TextSpan(
                style: theme.text16bold,
                text: 'Ending time',
                children: [
                  TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
                ]),
          ),
        ),
        InkWell(
          onTap: () {
            _selectTime(context, _endTimeController, endSelectedTime);
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: TextFormField(
              style: TextStyle(fontSize: 13.sp),
              enabled: false,
              keyboardType: TextInputType.text,
              controller: _endTimeController,
              decoration: InputDecoration(
                disabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.all(3.w),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ColorPickerWidget extends StatefulWidget {
  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  int choosenIndex = 0;
  List<MaterialColor> _list = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.brown
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.4.h),
          child: Text(
            'Select Color',
            style: theme.text14boldPimary,
          ),
        ),
        SizedBox(height: 0.6.h),
        Container(
          height: 50,
          child: ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    choosenIndex = index;
                  });
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: _list[index],
                    ),
                    if (choosenIndex == index)
                      Positioned(
                        left: 1.7.w,
                        top: 0.8.h,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      )
                  ],
                ),
              ),
            ),
            itemCount: _list.length,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }
}
