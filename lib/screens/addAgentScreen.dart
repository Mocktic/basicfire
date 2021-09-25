import 'package:cloud_functions/cloud_functions.dart' as cloud;
import 'package:contact/Models/AgentModel.dart';
import 'package:contact/Provider/agentProvider.dart';
import 'package:contact/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:random_string/random_string.dart';

enum Gender { Male, Female }

class AddAgentScreen extends StatefulWidget {
  final AgentsModel agentModel;
  final bool isEditing;
  AddAgentScreen({this.agentModel, this.isEditing});
  @override
  _AddAgentScreenState createState() => _AddAgentScreenState();
}

class _AddAgentScreenState extends State<AddAgentScreen>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  Gender agentGender;

  Widget buildRichText(String text1, String text2) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 1.w, bottom: 1.5.h, right: 1.w),
      child: RichText(
        text: TextSpan(style: theme.text16bold, text: text1, children: [
          TextSpan(text: text2, style: TextStyle(color: Colors.red)),
        ]),
      ),
    );
  }

  @override
  void initState() {
    if (widget.isEditing) {
      _nameController.text = widget.agentModel.name;
      _phoneController.text = widget.agentModel.phone;
      agentGender = widget.agentModel.gender;
      _emailController.text = widget.agentModel.email;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorBackground,
      appBar: AppBar(
        backgroundColor: theme.darkMode ? Colors.black : theme.colorPrimary,
        title: Text(!widget.isEditing ? 'Add Agent' : "Edit changes"),
      ),
      body: SingleChildScrollView(
        child: Container(
          //color: Colors.red,
          margin:
              EdgeInsets.only(right: 1.w, left: 1.w, top: 2.h, bottom: 0.5.h),
          //color: Colors.grey,
          padding:
              EdgeInsets.only(right: 5.w, left: 5.w, bottom: 1.h, top: 1.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                buildRichText('Agent Name', ' *'),
                Container(
                  child: TextFormField(
                    style: theme.robotoTextprimary,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        gapPadding: 4,
                        borderSide:
                            BorderSide(width: 2, color: Colors.grey[700]),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorPrimary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorPrimary),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorPrimary),
                      ),
                      labelText: 'Agent Name',
                      labelStyle: GoogleFonts.robotoSlab(
                        color: theme.colorPrimary,
                        fontSize: 18,
                      ),
                    ),
                    controller: _nameController,
                  ),
                ),
                SizedBox(height: 3.h),
                buildRichText('Email', ' *'),
                Container(
                  child: TextFormField(
                    style: theme.robotoTextprimary,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        gapPadding: 4,
                        borderSide: BorderSide(width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorPrimary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorPrimary),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorPrimary),
                      ),
                      labelText: 'Email',
                      labelStyle: GoogleFonts.robotoSlab(
                        color: theme.colorPrimary,
                        fontSize: 18,
                      ),
                    ),
                    enabled: !widget.isEditing,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                ),
                SizedBox(height: 3.h),
                buildRichText('Phone No.', ' *'),
                Container(
                  child: TextFormField(
                    style: theme.robotoTextprimary,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        gapPadding: 4,
                        borderSide: BorderSide(width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorPrimary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorPrimary),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorPrimary),
                      ),
                      labelText: 'Phone No.',
                      labelStyle: GoogleFonts.robotoSlab(
                        color: theme.colorPrimary,
                        fontSize: 18,
                      ),
                    ),
                    controller: _phoneController,
                  ),
                ),
                SizedBox(height: 3.h),
                buildRichText('Gender', ' *'),
                Container(
                  height: 8.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 1.h,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.7,
                        color: Colors.grey[700],
                      ),
                      borderRadius: BorderRadius.circular(4)),
                  child: DropdownButton(
                    dropdownColor: theme.colorBackground,
                    underline: SizedBox(),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down_sharp),
                    iconSize: 30.sp,
                    style: theme.robotoTextprimary,
                    onChanged: (value) {
                      setState(() {
                        agentGender = value;
                      });
                    },
                    items: [
                      DropdownMenuItem(child: Text('Male'), value: Gender.Male),
                      DropdownMenuItem(
                          child: Text('Female'), value: Gender.Female),
                    ],
                    value: agentGender,
                    hint: Text(
                      'Pick Gender',
                      style: GoogleFonts.robotoSlab(
                        color: theme.colorPrimary,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _isAdding
          ? Container(
              height: 7.h,
              child: SpinKitThreeBounce(
                color: theme.colorPrimary,
              ),
            )
          : InkWell(
              child: Container(
                alignment: Alignment.center,
                color: theme.addedColor,
                height: 7.h,
                width: double.infinity,
                child: Text(
                  widget.isEditing ? "Save Changes" : 'Add Agent',
                  style: theme.text18boldPrimary,
                ),
              ),
              onTap: () {
                addAgent();
              },
            ),
    );
  }

  Future<void> addAgent() async {
    setState(() {
      _isAdding = true;
    });
    //....
    final randomPass = randomAlphaNumeric(10);
    final userId =
        FirebaseDatabase.instance.reference().child("employee").push().key;
    final cloud.HttpsCallable callable =
        cloud.FirebaseFunctions.instance.httpsCallable(
      'createAgent',
    );
    callable.call({
      "Admin ID": FirebaseAuth.instance.currentUser.uid,
      "Name": _nameController.text,
      "email": _emailController.text,
      "gender": agentGender == Gender.Male ? "Male" : "Female",
      "Phone No.": _phoneController.text,
      "password": randomPass,
      "Agentuid": userId,
    }).catchError((onError) {
      Fluttertoast.showToast(msg: "Something went wrong");
    }).then((value) {
      afterprocess(userId);
    });
  }

  Future<void> afterprocess(userId) async {
    Map _map = {
      "Admin ID": FirebaseAuth.instance.currentUser.uid,
      "Name": _nameController.text,
      "email": _emailController.text,
      "gender": agentGender == Gender.Male ? "Male" : "Female",
      "Phone No": _phoneController.text,
      "Agentuid": userId.toString(),
      "new User": true,
      "UserType": "Agent"
    };
    print(_map);
    await FirebaseDatabase.instance
        .reference()
        .child("employee")
        .child(userId)
        .update({
      "Admin ID": FirebaseAuth.instance.currentUser.uid,
      "Name": _nameController.text,
      "email": _emailController.text,
      "gender": agentGender == Gender.Male ? "Male" : "Female",
      "Phone No": _phoneController.text,
      "Agentuid": userId.toString(),
      "new User": true,
      "UserType": "Agent",
      "Created": DateTime.now().toIso8601String()
    });
    Provider.of<AgentProvider>(context, listen: false).addAgent(AgentsModel(
        createdDate: DateTime.now(),
        email: _emailController.text,
        isChecked: false,
        name: _nameController.text,
        phone: _phoneController.text,
        photoUrl: null,
        userId: userId));
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: "deveshgarg9829@gmail.com");
    Fluttertoast.showToast(msg: "Agent is Created");
    Navigator.of(context).pop();
    setState(() {
      _isAdding = false;
    });
  }

  bool _isAdding = false;
}
