import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class CupoTextButton extends StatelessWidget {
  final String name;
  final Function onTapped;

  CupoTextButton({@required this.name, @required this.onTapped});
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: theme.buttonColor,
      borderRadius: BorderRadius.circular(30),
      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 40),
      child: Text(name, style: theme.text20),
      onPressed: onTapped,
    );
  }
}
