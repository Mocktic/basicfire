import 'package:contact/Config/Theme/theme.dart';
import 'package:contact/Provider/UserProvider.dart';
import 'package:contact/authentication/login/loginHomeScreen.dart';
import 'package:contact/screens/AgentsScreen.dart';
import 'package:contact/screens/HomeScreen.dart';
import 'package:contact/screens/MarketingScreen.dart';
import 'package:contact/screens/contactsScreen.dart';
import 'package:contact/screens/kanbanScreen.dart';
import 'package:contact/widgets/DrawerItem.dart';
import 'package:contact/widgets/ProfilePic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../main.dart';
import 'ProfileScreen.dart';
import 'SettingScreen.dart';
import 'WebsitePackage.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  Map<String, Map<IconData, Widget>> map = {
    "Home": {MdiIcons.home: HomeScreen()},
    "Contacts": {MdiIcons.contacts: ContactsScreen()},
    "Kanban Board": {MdiIcons.sortCalendarDescending: KanbanScreen()},
    "Agents": {MdiIcons.faceAgent: AgentsScreen()},
    "Marketing": {MdiIcons.marker: MarketingScreen()},
    "Website Packages": {MdiIcons.sale: Websitepackage()},
    "Team Task": {Icons.people: HomeScreen()},
    "Settings": {Icons.settings: SettingScreen()},
    "Log Out": {MdiIcons.logout: LoginHomeScreen()}
  };

  bool _change = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Drawer(
      child: Container(
        color: theme.colorBackground,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ));
              },
              child: Container(
                width: double.infinity,
                height: 15.h,
                color: theme.colorPrimary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProfilePic(),
                    Container(
                      width: 40.w,
                      child: Text(
                          user != null && user.firstName != null
                              ? "${user.firstName}"
                              : "User",
                          style: theme.text20bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Expanded(
              child: ListView(
                children: map.entries
                    .map((e) => DrawerItem(
                          icon: e.value.keys.first,
                          title: e.key,
                          onpressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => e.value.values.first,
                            ));
                          },
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
