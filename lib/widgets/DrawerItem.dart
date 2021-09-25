import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    @required this.icon,
    @required this.title,
    @required this.onpressed,
  });

  final IconData icon;
  final String title;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Column(
        children: [
          Container(
            height: 6.h,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 9.w,
                ),
                Icon(
                  icon,
                  color: theme.colorPrimary,
                ),
                SizedBox(
                  width: 9.w,
                ),
                Container(
                  width: 50.w,
                  child: Text(
                    title,
                    style: theme.text16Primary,
                  ),
                ),
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
