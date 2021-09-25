import 'package:contact/Models/ContactModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

class ContactDetailScreen extends StatelessWidget {
  ContactModel contact;
  ContactDetailScreen(this.contact);
  Widget buildRichText(String text1, String text2) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 1.w, bottom: 1.5.h, right: 1.w),
      child: RichText(
        text: TextSpan(
          style: theme.text16bold,
          text: text1,
          children: [
            TextSpan(text: text2, style: theme.text16Primary),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(String text1, String text2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: theme.text14boldPimary,
        ),
        Text(text2, style: theme.text12grey),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorBackground,
        body: NestedScrollView(
          key: UniqueKey(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.grey[700],
                // centerTitle: true,
                //backgroundColor: theme.colorPrimary,
                expandedHeight: 40.h,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  centerTitle: true,
                  title: Text(
                    contact.name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  background: Image.asset(
                    'assets/user_default_image2.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ];
          },
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 18),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTitle('+91 ${contact.phone}', 'Mobile'),

                    //SizedBox(width: 40.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          child: IconButton(
                              icon: Icon(
                                MdiIcons.phone,
                                color: Colors.white,
                              ),
                              onPressed: () {}),
                        ),
                        SizedBox(width: 5.w),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: Icon(
                              MdiIcons.message,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTitle(contact.email, 'Email'),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        icon: Icon(
                          MdiIcons.email,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTitle(contact.socialMediaLink, 'Social Media'),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        icon: Icon(
                          MdiIcons.link,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTitle(contact.companyName, 'Company'),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        icon: Icon(
                          Icons.business,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Divider(color: Colors.grey[400]),
                SizedBox(height: 2.h),
                Container(
                  child: Text('History', style: theme.text16Primary),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// Column(
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 30),
//               decoration: BoxDecoration(
//                   gradient: RadialGradient(
//                   radius: 1,
//                   colors: [theme.addedColor, theme.colorBackground],
//                 ),
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30)),
//               ),
//               height: 30.h,
//               width: double.infinity,
//               child: Column(
//                  children: [
//                   Image.asset(
//                     'assets/user_default_image2.png',
//                     fit: BoxFit.fill,
//                     height: 150,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     contact.name,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
           
//           ],
//         ),