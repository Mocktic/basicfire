import 'package:contact/Config/Theme/theme.dart';
import 'package:contact/screens/DrawerScreen.dart';
import 'package:contact/widgets/CustomAppbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../main.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var _notification = false;
  @override
  Widget build(BuildContext context) {
    var _change = Provider.of<AppThemeData>(context).darkMode;
    return Scaffold(
      backgroundColor: theme.colorBackground,
      appBar: customAppBar(context),
      body: ListView(
        children: [
          SwitchListTile(
            value: _change,
            activeColor: theme.colorPrimary,
            inactiveTrackColor: theme.colorPrimary,
            onChanged: (val) {
              Provider.of<AppThemeData>(context, listen: false)
                  .changeDarkMode();
              theme.changeDarkMode();
              setState(() {
                _change = val;
              });
            },
            title: Row(
              children: [
                Icon(
                  MdiIcons.themeLightDark,
                  color: theme.colorPrimary,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  theme.darkMode ? "Light Mode" : "Dark Mode",
                  style: theme.text16Primary,
                ),
              ],
            ),
          ),
          Divider(),
          SwitchListTile(
            value: _notification,
            activeColor: theme.colorPrimary,
            inactiveTrackColor: theme.colorPrimary,
            onChanged: (val) {
              setState(() {
                _notification = val;
              });
            },
            title: Row(
              children: [
                Icon(
                  MdiIcons.bell,
                  color: theme.colorPrimary,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  "Notifications",
                  style: theme.text16Primary,
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            trailing: Text(
              "🇬🇧",
              style: TextStyle(fontSize: 20),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.language,
                  color: theme.colorPrimary,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  "Language",
                  style: theme.text16Primary,
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.privacy_tip,
                  color: theme.colorPrimary,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  "Terms And Conditons",
                  style: theme.text16Primary,
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.security,
                  color: theme.colorPrimary,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  "Privacy Policy",
                  style: theme.text16Primary,
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
      drawer: DrawerScreen(),
    );
  }
}
