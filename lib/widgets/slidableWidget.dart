import 'package:contact/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableWidget extends StatelessWidget {
  final Widget child;
  final Function editFunction;
  final Function deleteFunction;
  const SlidableWidget(
      {Key key,
      @required this.child,
      @required this.editFunction,
      @required this.deleteFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // controller: SlidableController(),
      closeOnScroll: true,
      actionExtentRatio: 0.25,

      // actions: [

      // ],
      actions: [
        IconSlideAction(
          //key: ,
          icon: Icons.edit,
          caption: 'Edit',
          color: theme.addedMoreColor,
          onTap: editFunction,
        ),
        IconSlideAction(
          onTap: deleteFunction,
          icon: Icons.delete,
          caption: 'Delete',
          color: theme.contrastColor,
        )
      ],
      child: child,
      actionPane: SlidableDrawerActionPane(),
    );
  }
}
