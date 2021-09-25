import 'package:contact/Provider/providerSchedule.dart';
import 'package:contact/main.dart';
import 'package:contact/widgets/addScheduleWidget.dart';
import 'package:contact/widgets/scheduleCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // ignore: unused_field
  DateTime _selectedDay, _focusedDay;

  Future<void> showForm(BuildContext ctx) {
    return showCupertinoDialog(
        context: context, builder: (ctx) => AddScheduleWidget());
  }

  @override
  Widget build(BuildContext context) {
    var schedules = Provider.of<ScheduleProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Schedules'),
        backgroundColor: theme.colorPrimary,
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () => showForm(context)),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 4,
            colors: [theme.colorBackground, theme.addedColor],
          ),
        ),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: theme.addedMoreColor,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: theme.text14boldPimary,
                todayTextStyle: theme.text14primary,
                todayDecoration: BoxDecoration(
                    color: theme.colorGrey, shape: BoxShape.circle),
              ),
              // ignore: non_constant_identifier_names
              onFormatChanged: (CalendarFormat) {},
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
              },
            ),
            Expanded(
              //height: 40.h,
              child: ListView.builder(
                itemBuilder: (context, i) => Container(
                  margin: EdgeInsets.only(right: 10, left: 10, bottom: 12),
                  width: double.infinity,
                  child: ScheduleScreenCard(
                      scheduleContents: schedules.scheduleList[i]),
                ),
                itemCount: schedules.scheduleList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
