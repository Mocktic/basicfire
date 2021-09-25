import 'package:contact/Models/ContactModel.dart';
import 'package:contact/Provider/EmailProvider.dart';
import 'package:contact/Provider/contactProvider.dart';
import 'package:contact/screens/DrawerScreen.dart';
import 'package:contact/screens/mailScreen.dart';
import 'package:contact/widgets/CustomAppbar.dart';
import 'package:contact/widgets/SearchWidget.dart';
import 'package:contact/widgets/slidableWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

class MarketingScreen extends StatefulWidget {
  @override
  _MarketingScreenState createState() => _MarketingScreenState();
}

class _MarketingScreenState extends State<MarketingScreen> {
  final TextEditingController _searchController = TextEditingController();
  Widget buildRichText(String text1, String text2) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 1.w, bottom: 1.5.h, right: 1.w),
      child: RichText(
        text: TextSpan(style: theme.text16bold, text: text1, children: [
          TextSpan(text: text2, style: theme.text16Primary),
        ]),
      ),
    );
  }

  Widget _showDetails(ContactModel details) {
    return AlertDialog(
      actionsPadding: EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      scrollable: true,
      backgroundColor: theme.colorBackground,
      title: Text(details.name, style: theme.text20boldPrimary),
      content: Container(
        height: 30.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRichText('Email: ', details.email),
            buildRichText('Phone No. : ', details.phone),
            buildRichText('Company Name: ', details.companyName),
            buildRichText('Address: ', details.email),
            buildRichText('Social Media: ', details.socialMediaLink),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          //style: ElevatedButton.,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        )
      ],
    );
  }

  @override
  void initState() {
    var contactProvider = Provider.of<ContactProvider>(context, listen: false);
    contactProvider.fetchdetails();
    super.initState();
  }

  List<String> mailTo = [];

  @override
  Widget build(BuildContext context) {
    var contactProvider = Provider.of<ContactProvider>(context);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: (contactProvider.contacts
                .any((ContactModel contact) => contact.isSelected == true))
            ? FloatingActionButton(
                backgroundColor: theme.addedColor,
                // radius: 3.5.h,
                onPressed: () {
                  final ls = contactProvider.contacts
                      .where((element) => element.isSelected)
                      .toList();
                  ls.forEach((element) {
                    mailTo.add(element.email);
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MailScreen(
                        mailTo: mailTo,
                      ),
                    ),
                  );
                },
                child: Icon(
                  MdiIcons.send,
                  size: 22.sp,
                  color: theme.colorPrimary,
                ),
              )
            : Container(),
        backgroundColor: theme.colorBackground,
        appBar: customAppBar(context),
        drawer: DrawerScreen(),
        body: Container(
          margin: EdgeInsets.only(top: 1.h, left: 2.w, right: 2.w),
          padding:
              EdgeInsets.only(top: 1.h, left: 2.w, right: 1.w, bottom: 1.5.h),
          height: double.infinity,
          width: double.infinity,
          //color: Colors.red,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    //color: theme.colorGrey,
                    // width: 70.w,
                    child: InkWell(
                      onTap: () {
                        if (contactProvider.contacts.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("No contact Found"),
                              content: Text("Nothing to search"),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"))
                              ],
                            ),
                          );
                          return;
                        }
                        showSearch(
                            context: context,
                            delegate:
                                SearchContact(ls: contactProvider.contacts));
                      },
                      child: TextFormField(
                        enabled: false,
                        style: theme.robotoTextprimary,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[500],
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          //fillColor: theme.colorPrimary,
                          // border: OutlineInputBorder(
                          //   borderSide: BorderSide(
                          //     color: Colors.grey[500],
                          //   ),
                          //   borderRadius: BorderRadius.circular(15),
                          // ),
                          prefixIcon:
                              Icon(Icons.search, color: Colors.grey[500]),
                          hintText: 'Search Contact',
                          hintStyle: GoogleFonts.robotoSlab(
                            color: Colors.grey[500],
                            fontSize: 16,
                          ),
                        ),
                        controller: _searchController,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      MdiIcons.import,
                      color: theme.colorPrimary,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      MdiIcons.export,
                      color: theme.colorPrimary,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, i) => Column(
                    children: [
                      SlidableWidget(
                        deleteFunction: () {
                          print('Agent Deleted');
                        },
                        editFunction: () {
                          print('Editing Agent');
                        },
                        child: Container(
                          //color: Colors.red,
                          width: 90.w,
                          margin: EdgeInsets.symmetric(
                            horizontal: 1.w,
                          ),
                          child: Card(
                            shadowColor: theme.colorPrimary,
                            elevation: 2,
                            color: theme.colorBackground,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.zero,
                            child: CheckboxListTile(
                              // tileColor: theme.colorPrimary,
                              //activeColor: theme.addedColor,
                              selectedTileColor: theme.colorPrimary,
                              controlAffinity: ListTileControlAffinity.leading,
                              dense: false,
                              checkColor: theme.colorPrimary,
                              value: contactProvider.contacts[i].isSelected,
                              title: Text(contactProvider.contacts[i].name,
                                  style: theme.text14bold),
                              subtitle: Text(
                                contactProvider.contacts[i].email,
                                style: theme.text14primary,
                              ),
                              onChanged: (val) {
                                setState(() {
                                  contactProvider.contacts[i].isSelected = val;
                                });
                              },

                              // leading: CircleAvatar(
                              //   backgroundImage: NetworkImage(
                              //       contactProvider.contacts[i].photoUrl),
                              // ),
                              secondary: IconButton(
                                icon: Icon(
                                  MdiIcons.information,
                                  color: theme.colorPrimary,
                                  size: 22.sp,
                                ),
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) =>
                                      _showDetails(contactProvider.contacts[i]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider()
                    ],
                  ),
                  itemCount: contactProvider.contacts.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
