import 'package:contact/Config/Enum/userTypes.dart';
import 'package:contact/Models/AppointmentModel.dart';
import 'package:contact/Models/ScheduledTimeModel.dart';
import 'package:contact/Models/UserModel.dart';
import 'package:contact/Provider/UserProvider.dart';
import 'package:contact/screens/DrawerScreen.dart';
import 'package:contact/screens/scheduleScreen.dart';
import 'package:contact/widgets/ProfilePic.dart';
import 'package:contact/widgets/appointmentCard.dart';
import 'package:contact/widgets/barChartWidget.dart';
import 'package:contact/widgets/lineChartWidget.dart';
import 'package:contact/widgets/pieChart.dart';
import 'package:contact/widgets/sheduledTimeCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field
  DateTime _selectedDay, _focusedDay;
  var appointmentList = [
    AppointmentModel(
      email: 'coooladarshmaheshwari6112001@gmail.com',
      imageURL: 'kajff/google.com',
      name: 'Adarsh Tapariya',
      phone: '9829687592',
      time: '10:30 PM',
      title: 'Important',
    ),
    AppointmentModel(
      email: 'coooladarshmaheshwari6112001@gmail.com',
      imageURL: 'kajff/google.com',
      name: 'Adarsh Tapariya',
      phone: '9829687592',
      time: '10:30 PM',
      title: 'Important',
    ),
    AppointmentModel(
      email: 'coooladarshmaheshwari6112001@gmail.com',
      imageURL: 'kajff/google.com',
      name: 'Adarsh Tapariya',
      phone: '9829687592',
      time: '10:30 PM',
      title: 'Important',
    ),
  ];

  var scheduledList = [
    ScheduleModel(
      title: 'Schedule Tile',
      description:
          'This is a test description! Let\'s see how much text it can hold without overflowing the card. ',
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 2)),
    ),
    ScheduleModel(
      title: 'Schedule Tile',
      description:
          'This is a test description! Let\'s see how much text it can hold without overflowing the card. ',
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 2)),
    ),
    ScheduleModel(
      title: 'Schedule Tile',
      description:
          'This is a test description! Let\'s see how much text it can hold without overflowing the card. ',
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 2)),
    ),
  ];

  void fetchUserInformation() async {
    final data = await FirebaseDatabase.instance
        .reference()
        .child("User Information")
        .child(FirebaseAuth.instance.currentUser.uid)
        .once();
    final datasnap = data.value as Map;
    if (datasnap == null) {
      Fluttertoast.showToast(msg: "You are removed");
      return;
    } else {
      final user = UserModel(
        firstName: datasnap['First Name'],
        gender: datasnap['gender'],
        lastName: datasnap['Last Name'],
        phoneNumber: datasnap['phone'],
        photoURL: datasnap['photoURL'],
        uid: FirebaseAuth.instance.currentUser.uid,
        userType: datasnap['UserType'] == "Admin"
            ? UsersType.Admin
            : datasnap['UserType'] == "Super"
                ? UsersType.SuperAdmin
                : UsersType.agent,
      );

      print(datasnap);
      Provider.of<UserProvider>(context, listen: false).setCurrentUser(user);
    }
  }

  @override
  void initState() {
    fetchUserInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorBackground,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black, size: 35),
          backgroundColor: Color(0xff232323),
          elevation: 5,
          leading: Builder(
            builder: (context) => IconButton(
                icon: (Icon(
                  MdiIcons.formatAlignLeft,
                  size: 20.sp,
                  color: theme.colorCompanion,
                )),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                }),
          ),
          actions: [
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 13),
              child: ProfilePic(),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 4,
              colors: [theme.colorBackground, theme.addedColor],
            ),
          ),
          // color: Colors.red,
          child: ListView(
            children: [
              SizedBox(height: 0.7.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Schedule',
                      style: theme.text18boldPrimary,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ScheduleScreen(),
                        ));
                      },
                      child: Text('See All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.5.h),

              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                calendarFormat: CalendarFormat.twoWeeks,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: theme.addedMoreColor,
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: theme.text14primary,
                  outsideTextStyle: theme.text14primary,
                  rangeEndTextStyle: theme.text14primary,
                  holidayTextStyle: theme.text14primary,
                  weekendTextStyle: theme.text14primary,
                  disabledTextStyle: theme.text14primary,
                  rangeStartTextStyle: theme.text14primary,
                  withinRangeTextStyle: theme.text14primary,
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
                    _focusedDay =
                        focusedDay; // update `_focusedDay` here as well
                  });
                },
              ),
              SizedBox(height: 1.h),
              Container(
                margin: EdgeInsets.only(right: 5, bottom: 12, left: 5),
                height: 20.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) => Container(
                    child: ScheduleTimeCard(scheduledList[i]),
                  ),
                  itemCount: scheduledList.length,
                ),
              ),
              // SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Appointments',
                      style: theme.text18boldPrimary,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('See All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.5.h),
              Container(
                margin: EdgeInsets.only(right: 5, bottom: 12, left: 5),
                height: 25.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) => Container(
                      //color: Colors.red,
                      // margin: EdgeInsets.symmetric(horizontal: 7),
                      child: AppointmentCard(appointmentList[i])),
                  itemCount: appointmentList.length,
                ),
              ),
              SizedBox(height: 2.5.h),
              Row(
                children: [
                  PieChart(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            color: theme.addedColor,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "No. of Agents",
                            overflow: TextOverflow.ellipsis,
                            style: theme.text14boldPimary,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            color: theme.colorPrimary,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "Max Agents",
                            overflow: TextOverflow.ellipsis,
                            style: theme.text14boldPimary,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                //color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: BarChartWidget(),
              ),
              SizedBox(height: 0.5.h),
              Container(
                //color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: LineChartWidget(),
              ),
            ],
          ),
        ),
        drawer: DrawerScreen(),
      ),
    );
  }
}
