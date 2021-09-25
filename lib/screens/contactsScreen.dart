import 'dart:io';

import 'package:contact/Config/Helper/JsonParse.dart';
import 'package:contact/Models/ContactModel.dart';
import 'package:contact/Provider/contactProvider.dart';
import 'package:contact/screens/DrawerScreen.dart';
import 'package:contact/screens/contactDetailsScreen.dart';
import 'package:contact/widgets/CustomAppbar.dart';
import 'package:contact/widgets/SearchWidget.dart';
import 'package:contact/widgets/slidableWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
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

  // Widget _showDetails(ContactModel details) {
  //   return AlertDialog(
  //     actionsPadding: EdgeInsets.symmetric(horizontal: 10),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //     scrollable: true,
  //     backgroundColor: theme.colorBackground,
  //     title: Text(details.name, style: theme.text20boldPrimary),
  //     content: Container(
  //       height: 30.h,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           buildRichText('Email: ', details.email),
  //           buildRichText('Phone No. : ', details.phone),
  //           buildRichText('Company Name: ', details.companyName),
  //           buildRichText('Address: ', details.email),
  //           buildRichText('Social Media: ', details.socialMediaLink),
  //         ],
  //       ),
  //     ),
  //     actions: [
  //       ElevatedButton(
  //         //style: ElevatedButton.,
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         child: Text('OK'),
  //       )
  //     ],
  //   );
  // }

  @override
  void initState() {
    Provider.of<ContactProvider>(context, listen: false).fetchdetails();
    super.initState();
  }

  bool _isFetching = false;
  @override
  Widget build(BuildContext context) {
    var contactProvider = Provider.of<ContactProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorBackground,
        appBar: contactProvider.contacts.any((element) => element.isSelected)
            ? AppBar(
                iconTheme: IconThemeData(color: Colors.black, size: 35),
                backgroundColor: Color(0xff232323),
                elevation: 3,
                shadowColor: theme.colorPrimary,
                leading: IconButton(
                  onPressed: () {
                    final list = contactProvider.contacts
                        .where((element) => element.isSelected)
                        .toList();
                    list.forEach((element) {
                      final int i = contactProvider.contacts.indexOf(element);
                      contactProvider.contacts[i].isSelected = false;
                    });
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.close,
                    color: theme.primarySwatch,
                  ),
                ),
                title: Text(contactProvider.contacts
                        .where((element) => element.isSelected)
                        .toList()
                        .length
                        .toString() +
                    " Selected"),
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _isFetching = true;
                        });
                        final list = contactProvider.contacts
                            .where((element) => element.isSelected)
                            .toList();
                        for (var i = 0; i < list.length; i++) {
                          contactProvider.delete(list[i].id);
                        }
                        setState(() {
                          _isFetching = false;
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: theme.primarySwatch,
                      ))
                ],
              )
            : customAppBar(context),
        drawer: DrawerScreen(),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 1.h, left: 2.w, right: 2.w),
              padding: EdgeInsets.only(
                  top: 1.h, left: 2.w, right: 1.w, bottom: 1.5.h),
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
                                  // backgroundColor: theme.colorPrimary,
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
                              delegate: SearchContact(
                                ls: contactProvider.contacts,
                              ),
                            );
                          },
                          child: TextFormField(
                            style: theme.robotoTextprimary,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 1.h),
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
                            enabled: false,
                            controller: _searchController,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          MdiIcons.upload,
                          color: theme.colorPrimary,
                        ),
                        onPressed: () async {
                          try {
                            final path =
                                await FlutterDocumentPicker.openDocument();
                            if (path == null) {
                              return;
                            }
                            setState(() {
                              _isFetching = true;
                            });
                            File newfile = File(path);

                            final data = await excelToJson(
                                "abcd", "${newfile.parent}", newfile);
                            // print(data);
                            await Provider.of<ContactProvider>(context,
                                    listen: false)
                                .decodeAddData(data);
                            await Future.delayed(Duration(seconds: 3));
                            setState(() {
                              _isFetching = false;
                            });
                          } catch (e) {
                            Fluttertoast.showToast(msg: "something went wrong");
                            setState(() {
                              _isFetching = false;
                            });
                            print(e);
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          MdiIcons.download,
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
                              //height: 10.h,
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
                                  tileColor: theme.colorBackgroundGray,
                                  activeColor: theme.addedColor,
                                  selectedTileColor: theme.colorPrimary,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
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
                                      contactProvider.contacts[i].isSelected =
                                          val;
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
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ContactDetailScreen(
                                                contactProvider.contacts[i]),
                                      ),
                                    ),

                                    // showDialog(
                                    //   context: context,
                                    //   builder: (context) => _showDetails(
                                    //       contactProvider.contacts[i]),
                                    // ),
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
            if (_isFetching)
              Container(
                width: double.maxFinite,
                height: double.infinity,
                color: Colors.black54.withOpacity(0.5),
                child: Center(
                  child: Container(
                      width: 150,
                      height: 150,
                      padding: EdgeInsets.all(30),
                      color: theme.colorPrimary,
                      child: SpinKitChasingDots(
                        color: theme.addedColor,
                      )),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
