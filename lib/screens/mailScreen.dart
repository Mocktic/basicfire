import 'package:contact/Provider/EmailProvider.dart';
import 'package:contact/main.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MailScreen extends StatefulWidget {
  final List<String> mailTo;
  MailScreen({this.mailTo});

  @override
  _MailScreenState createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  TextEditingController _from = TextEditingController();
  TextEditingController _toController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    print(widget.mailTo);
    _toController.text = widget.mailTo.join(", ");
    print(_toController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorBackground,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: theme.colorPrimary,
          title: Text(
            'Compose',
            //style: theme.text,
          ),
          actions: [
            IconButton(
                icon: Icon(
                  MdiIcons.attachment,
                  color: theme.colorBackground,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  MdiIcons.send,
                  color: Colors.blue,
                ),
                onPressed: () {
                  Provider.of<EmailProvider>(context, listen: false)
                      .sendEmail("subject", "", widget.mailTo);
                }),
            IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: theme.colorBackground,
                ),
                onPressed: () {})
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Container(
                      child: Text('From', style: theme.text14bold),
                      alignment: Alignment.centerLeft,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.expand_more,
                        color: theme.colorPrimary,
                        size: 15.sp,
                      ),
                      onPressed: () {},
                    )),
              ),
              TextFormField(
                controller: _toController,
                decoration: InputDecoration(
                  prefixIcon: Container(
                    //padding: EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'To',
                      style: theme.text14bold,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.expand_more,
                      color: theme.colorPrimary,
                      size: 15.sp,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              TextFormField(
                style: theme.text12Primary,
                decoration: InputDecoration(
                  hintText: 'Subject',
                  hintStyle: theme.text12grey,
                ),
                controller: _subjectController,
              ),
              TextFormField(
                style: theme.text12Primary,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: 'Compose Email',
                  hintStyle: theme.text12grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
