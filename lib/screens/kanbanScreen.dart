import 'package:contact/Models/SectionModel.dart';
import 'package:contact/Models/TaskModel.dart';
import 'package:contact/Provider/kanbanBoardProvider.dart';
import 'package:contact/screens/DrawerScreen.dart';
import 'package:contact/screens/HomeScreen.dart';
import 'package:contact/screens/addTaskScreen.dart';
import 'package:contact/widgets/CustomAppbar.dart';
//import 'package:contact/widgets/kanbanSectionTaskWidget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../widgets/CustomAppbar.dart';

import '../main.dart';

class KanbanScreen extends StatefulWidget {
  @override
  _KanbanScreenState createState() => _KanbanScreenState();
}

class _KanbanScreenState extends State<KanbanScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<KanbanBoardProvider>(context, listen: false)
        .allSections();
    await Provider.of<KanbanBoardProvider>(context, listen: false)
        .allTasks(DateTime.now());
    setState(() {
      _isLoading = false;
    });
  }

  TextEditingController _sectionController = TextEditingController();
  bool _isLoading = false;

  Future<String> onSectionPressed(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: theme.colorBackground,
          title: Text('Section Name', style: theme.text18boldPrimary2),
          content: Container(
            //decoration: BoxDecoration(color: theme.colorBackground),
            height: 16.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Section Name',
                      hintStyle: GoogleFonts.merriweather(
                          fontSize: 16, color: theme.colorGrey),
                    ),
                    controller: _sectionController,
                  ),
                ),
                // SizedBox(height: 4.h),
                _isLoading
                    ? SpinKitThreeBounce(
                        color: theme.colorCompanion,
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (_sectionController.text.isEmpty) {
                                  return 'You can\'t save an empty field';
                                }
                                setState(() {
                                  _isLoading = true;
                                });
                                print(_sectionController.text);

                                await Provider.of<KanbanBoardProvider>(context,
                                        listen: false)
                                    .addSection(
                                  Sectionmodel(
                                    Name: _sectionController.text,
                                    id: null,
                                  ),
                                );
                                _sectionController.clear();
                                setState(() {
                                  _isLoading = false;
                                });

                                Navigator.of(context).pop();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 27.w,
                                decoration: BoxDecoration(
                                  color: theme.addedColor,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.5.h, horizontal: 3.w),
                                child: Text('Add', style: theme.text14primary),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 27.w,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(7)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.5.h, horizontal: 3.w),
                                child: Text(
                                  'Cancel',
                                  style: theme.text14primary,
                                  //textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          )),
    );
  }

  // Widget buildDashedBorder(Widget child, Color borderColor) {
  //   return DottedBorder(
  //     padding: EdgeInsets.symmetric(horizontal: 3.3.w),
  //     borderType: BorderType.RRect,
  //     radius: Radius.circular(15),
  //     strokeWidth: 3,
  //     dashPattern: [10, 7],
  //     child: child,
  //     color: borderColor,
  //     strokeCap: StrokeCap.round,
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       backgroundColor: theme.colorBackground,
  //       appBar: customAppBar(context),
  //       resizeToAvoidBottomInset: false,
  //       drawer: DrawerScreen(),
  //       body: _isLoading
  //           ? Center(
  //               child: SpinKitThreeBounce(
  //                 color: theme.colorPrimary,
  //               ),
  //             )
  //           : Column(
  //               children: [
  //                 SizedBox(
  //                   height: 5.h,
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     Container(
  //                       margin: EdgeInsets.only(left: 3.w),
  //                       child: buildDashedBorder(
  //                         GestureDetector(
  //                           onTap: () {
  //                             onSectionPressed(context);
  //                           },
  //                           child: Container(
  //                             height: 15.h,
  //                             width: 32.w,
  //                             //margin: EdgeInsets.only(left: 3.w, right: 3.w),
  //                             child: Column(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Icon(
  //                                   Icons.add,
  //                                   size: 40.sp,
  //                                 ),
  //                                 SizedBox(height: 2.h),
  //                                 FittedBox(
  //                                   child: Text(
  //                                     'Add Section',
  //                                     style: theme.text18boldPrimary2,
  //                                     textAlign: TextAlign.center,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                         theme.addedMoreColor,
  //                       ),
  //                     ),
  //                     GestureDetector(
  //                       onTap: () {
  //                         Navigator.of(context).push(
  //                           MaterialPageRoute(
  //                             builder: (context) => AddTaskScreen(
  //                               isEdit: false,
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                       child: Container(
  //                         margin: EdgeInsets.only(right: 3.w),
  //                         child: buildDashedBorder(
  //                           Container(
  //                             height: 15.h,
  //                             width: 32.w,
  //                             //margin: EdgeInsets.only(left: 3.w, right: 3.w),
  //                             child: Column(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Icon(
  //                                   Icons.add,
  //                                   size: 40.sp,
  //                                 ),
  //                                 SizedBox(height: 2.h),
  //                                 FittedBox(
  //                                   child: Text(
  //                                     'Add Task',
  //                                     style: theme.text18boldPrimary2,
  //                                     textAlign: TextAlign.center,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           theme.contrastColor,
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //                 Expanded(
  //                   child: KanbanSectionTaskWidget(),
  //                 )
  //               ],
  //             ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    var kanbanSection = Provider.of<KanbanBoardProvider>(context);
    kanbanSection.convertor();
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorBackground,
        drawer: DrawerScreen(),
        appBar: customAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            //color: Colors.green,
            height: 100.h,
            width: 100.w,
            child: Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 12, right: 8, bottom: 7),
                    child: Text('Kanban', style: theme.text18boldPrimary2),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 15, left: 12, right: 8, bottom: 12),
                    child: Row(
                      children: [
                        InkWell(
                          child: Text(
                            'Dashboard',
                            style: theme.text12bold,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                        ),
                        Text(
                          ' > Kanban',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      //shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: dataWidget(
                        kanbanSection.convertedData,
                        context,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> dataWidget(
      Map<Sectionmodel, List<TaskModel>> map, BuildContext context) {
    List<Widget> _list = [];
    //print(map);
    map.forEach(
      (key, value) {
        _list.add(
          Container(
            margin: EdgeInsets.only(top: 10, right: 8, left: 12, bottom: 5),
            //color: Colors.red,
            alignment: Alignment.topCenter,
            width: 70.w,
            // height: 70.h,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              color: theme.darkMode ? Colors.black54 : Colors.grey[200],
              elevation: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    //height: 70.h,
                    padding: EdgeInsets.only(
                        left: 30, top: 15, right: 10, bottom: 15),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(key.Name, style: theme.text16bold),
                        IconButton(
                          icon: Icon(Icons.more_horiz, color: Colors.grey[700]),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: value
                        .map((task) => Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 10, bottom: 20),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: CheckboxListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 7),
                                  activeColor: theme.colorBackground,
                                  tileColor: theme.colorBackground,
                                  //selectedTileColor: Colors.grey,
                                  checkColor: Colors.green,
                                  shape: CircleBorder(
                                    side: BorderSide(color: Colors.black),
                                  ),
                                  dense: false,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: task.isCompleted,
                                  onChanged: (val) {
                                    setState(() {
                                      task.isCompleted = val;
                                    });
                                  },
                                  title: Text(
                                    task.taskName,
                                    style: TextStyle(
                                        color: task.isCompleted
                                            ? Colors.grey[400]
                                            : (theme.darkMode
                                                ? (Colors.white)
                                                : Colors.black)),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTaskScreen(
                            isEdit: false,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      '+ Add Task',
                      style: TextStyle(
                        color: theme.colorPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    _list.add(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => onSectionPressed(context),
            child: Container(
              alignment: Alignment.center,
              height: 7.h,
              width: 60.w,
              margin: EdgeInsets.symmetric(vertical: 18, horizontal: 5),
              //color: Colors.red,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                '+ Add Section',
                style: TextStyle(
                  color: theme.colorPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return _list;
  }
}
