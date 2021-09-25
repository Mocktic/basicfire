import 'package:contact/Config/Enum/Priority.dart';
import 'package:contact/Models/AgentModel.dart';
import 'package:contact/Models/SectionModel.dart';
import 'package:contact/Models/TaskModel.dart';
import 'package:contact/Provider/agentProvider.dart';
import 'package:contact/Provider/kanbanBoardProvider.dart';
import 'package:contact/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddTaskScreen extends StatefulWidget {
  final bool isEdit;
  final TaskModel taskmodelEdits;
  AddTaskScreen({
    this.isEdit,
    this.taskmodelEdits,
  });
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var _formKey = GlobalKey<FormState>();
  WorkPriority _priority;
  Sectionmodel _section;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  // ignore: non_constant_identifier_names
  List<AgentsModel> Selectedagents = [];

  List<Sectionmodel> sectionList = [];
  List<AgentsModel> agents = [];

  @override
  void didChangeDependencies() {
    sectionList = Provider.of<KanbanBoardProvider>(context).sections;
    agents = Provider.of<AgentProvider>(context, listen: false).agents;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    agents = Provider.of<AgentProvider>(context, listen: false).agents;
    if (agents == null || agents.isEmpty) {
      Provider.of<AgentProvider>(context, listen: false).getAllAgents();
    }

    if (widget.isEdit) {
      widget.taskmodelEdits.assignIDs.forEach((key, value) {
        Selectedagents.add(
          AgentsModel(
              userId: key,
              isChecked: true,
              photoUrl: value['imageURL'],
              name: value['Name']),
        );
      });
      Selectedagents.forEach((eleme) {
        int index = Provider.of<AgentProvider>(context, listen: false)
            .agents
            .indexWhere((element) => element.userId == eleme.userId);
        if (index != -1) {
          Provider.of<AgentProvider>(context, listen: false)
              .agents[index]
              .isChecked = true;
        }
      });
      _priority = widget.taskmodelEdits.priority;
      sectionList =
          Provider.of<KanbanBoardProvider>(context, listen: false).sections;
      _section = sectionList.firstWhere(
          (element) => element.id == widget.taskmodelEdits.sectionID);
      _nameController.text = widget.taskmodelEdits.taskName;
      _descriptionController.text = widget.taskmodelEdits.description;
      _dateController.text =
          DateFormat.yMd().format(widget.taskmodelEdits.dueDate);
      selectedDate = widget.taskmodelEdits.dueDate;
    }
    super.initState();
  }

  Widget addIcon() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: CircleAvatar(
        radius: 3.1.h,
        backgroundColor: theme.colorPrimary,
        child: CircleAvatar(
          backgroundColor: theme.colorBackground,
          radius: 3.h,
          child: InkWell(
            child: Icon(Icons.add, size: 30.sp),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  titlePadding: EdgeInsets.only(
                      bottom: 0.7.h, left: 6.w, right: 6.w, top: 2.h),
                  contentPadding: EdgeInsets.only(
                      right: 4.w, left: 4.w, bottom: 0, top: 2.h),
                  title: Text(
                    'Select Assignee',
                    style: theme.text18boldPrimary,
                  ),
                  content: Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: CheckBoxListTile(),
                    ),
                  ),
                  actions: [
                    Container(
                      width: double.infinity,
                      height: 6.h,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.colorPrimary),
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          Selectedagents =
                              Provider.of<AgentProvider>(context, listen: false)
                                  .agents
                                  .where((element) => element.isChecked)
                                  .toList();
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Select',
                          style: theme.text16boldWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        final list = Provider.of<AgentProvider>(context, listen: false)
            .agents
            .where((element) => element.isChecked)
            .toList();
        list.forEach((element) {
          int index = Provider.of<AgentProvider>(context, listen: false)
              .agents
              .indexOf(element);
          Provider.of<AgentProvider>(context, listen: false)
              .agents[index]
              .isChecked = false;
        });
        Navigator.of(context).pop();
        return;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: theme.colorBackground,
          appBar: AppBar(
            backgroundColor: theme.darkMode ? Colors.black : theme.colorPrimary,
            title: Text(widget.isEdit ? "Edit Task" : 'Add Task'),
          ),
          // resizeToAvoidBottomInset: false,
          body: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(
                    right: 1.w, left: 1.w, top: 2.h, bottom: 0.5.h),
                //color: Colors.grey,
                padding: EdgeInsets.only(
                    right: 5.w, left: 5.w, bottom: 1.h, top: 1.h),
                height: 80.h,
                child: ListView(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            child: TextFormField(
                              style: theme.robotoTextprimary,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  gapPadding: 4,
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey[500],
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  gapPadding: 4,
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                labelText: 'Name',
                                labelStyle: GoogleFonts.robotoSlab(
                                    fontSize: 18, color: theme.colorPrimary),
                              ),
                              // initialValue:
                              //     widget.isEdit ? _nameController.text : null,
                              controller: _nameController,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.4.h),
                            child: RichText(
                              text: TextSpan(
                                style: theme.text18boldPrimary2,
                                text: 'Assigned To',
                                children: [
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          if (Selectedagents.isEmpty)
                            Container(
                              child: addIcon(),
                              alignment: Alignment.centerLeft,
                            )
                          else
                            Container(
                              height: 7.h,
                              width: 90.w,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, i) {
                                  //print('list builder called');
                                  return Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 4.h,
                                        backgroundImage:
                                            Selectedagents[i].photoUrl != null
                                                ? NetworkImage(
                                                    Selectedagents[i].photoUrl)
                                                : null,
                                        child:
                                            Selectedagents[i].photoUrl != null
                                                ? null
                                                : Center(
                                                    child: Text(
                                                      Selectedagents[i]
                                                          .name[0]
                                                          .toUpperCase(),
                                                      style: theme.text20bold,
                                                    ),
                                                  ),
                                      ),
                                      if (i + 1 >= Selectedagents.length)
                                        addIcon(),
                                      SizedBox(width: 1.w)
                                    ],
                                  );
                                },
                                itemCount: Selectedagents.length,
                              ),
                            ),
                          SizedBox(
                            height: 3.h,
                          ),
                          datePicker(),
                          SizedBox(height: 3.h),
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
                              focusColor: theme.colorPrimary,
                              dropdownColor: theme.colorBackground,
                              underline: SizedBox(),
                              isExpanded: true,
                              icon: Icon(Icons.arrow_drop_down_sharp),
                              iconSize: 30.sp,
                              style: theme.robotoTextprimary,
                              onChanged: (value) {
                                setState(() {
                                  _priority = value;
                                });
                              },
                              items: [
                                DropdownMenuItem(
                                    child: Text('High'),
                                    value: WorkPriority.High),
                                DropdownMenuItem(
                                    child: Text('Medium'),
                                    value: WorkPriority.Medium),
                                DropdownMenuItem(
                                    child: Text('Low'),
                                    value: WorkPriority.Low),
                              ],
                              value: _priority,
                              hint: Text(
                                'Pick Work Priority',
                                style: GoogleFonts.robotoSlab(
                                  color: theme.colorPrimary,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Container(
                            child: TextFormField(
                              maxLines: 3,
                              style: theme.robotoTextprimary,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  gapPadding: 4,
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey[500],
                                  ),
                                ),
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                  gapPadding: 4,
                                  borderSide: BorderSide(width: 2),
                                ),
                                labelText: 'Description',
                                labelStyle: GoogleFonts.robotoSlab(
                                  fontSize: 18,
                                  color: theme.colorPrimary,
                                ),
                              ),
                              // initialValue: widget.isEdit
                              //     ? _descriptionController.text
                              //     : null,
                              controller: _descriptionController,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          //Section DropDown
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
                            child: DropdownButton<Sectionmodel>(
                              dropdownColor: theme.colorBackground,
                              underline: SizedBox(),
                              isExpanded: true,
                              icon: Icon(Icons.arrow_drop_down_sharp),
                              iconSize: 30.sp,
                              style: theme.robotoTextprimary,
                              onChanged: (value) {
                                setState(() {
                                  _section = value;
                                });
                              },
                              items: sectionList
                                  .map(
                                    (section) => DropdownMenuItem(
                                      child: Text(section.Name),
                                      value: section,
                                    ),
                                  )
                                  .toList(),
                              value: _section,
                              hint: Text(
                                'Pick Section',
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
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: _isLoading
              ? Container(
                  height: 7.h,
                  child: SpinKitThreeBounce(
                    color: theme.colorPrimary,
                  ),
                )
              : InkWell(
                  onTap: () async {
                    if (!_formKey.currentState.validate() ||
                        Selectedagents.isEmpty) {
                      return;
                    }
                    setState(() {
                      _isLoading = true;
                    });
                    final list =
                        Provider.of<AgentProvider>(context, listen: false)
                            .agents
                            .where((element) => element.isChecked)
                            .toList();
                    Map<String, Map<String, String>> _map = {};
                    list.forEach((element) {
                      _map.putIfAbsent(element.userId, () => {});
                      _map[element.userId]
                          .putIfAbsent("Name", () => element.name);
                      _map[element.userId]
                          .putIfAbsent("imageURL", () => element.photoUrl);
                    });
                    await Provider.of<KanbanBoardProvider>(context,
                            listen: false)
                        .addNewTask(
                            _nameController.text,
                            _descriptionController.text,
                            _map,
                            _priority,
                            selectedDate,
                            _section);
                    list.forEach((element) {
                      int index =
                          Provider.of<AgentProvider>(context, listen: false)
                              .agents
                              .indexOf(element);
                      Provider.of<AgentProvider>(context, listen: false)
                          .agents[index]
                          .isChecked = false;
                    });
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: theme.addedColor,
                    height: 7.h,
                    width: double.infinity,
                    child: Text(
                      widget.isEdit ? "Save changes" : 'Add Task',
                      style: theme.text18boldPrimary,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  bool _isLoading = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Widget datePicker() {
    return Column(
      children: [
        SizedBox(height: 0.7.h),
        InkWell(
          onTap: () {
            _selectDate(
              context,
            );
          },
          child: Container(
            child: TextFormField(
              enabled: false,
              style: theme.robotoTextprimary,
              decoration: InputDecoration(
                focusColor: Colors.blue,
                enabledBorder: OutlineInputBorder(
                  gapPadding: 4,
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.grey[700],
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                    gapPadding: 4,
                    borderSide:
                        BorderSide(width: 0.5, color: Colors.grey[700])),
                labelText: 'Due Date',
                labelStyle: GoogleFonts.robotoSlab(
                  color: theme.colorPrimary,
                  fontSize: 18,
                ),
              ),
              // initialValue: widget.isEdit ? _dateController.text : null,
              controller: _dateController,
            ),
          ),
        ),
      ],
    );
  }
}

class CheckBoxListTile extends StatefulWidget {
  @override
  _CheckBoxListTileState createState() => _CheckBoxListTileState();
}

class _CheckBoxListTileState extends State<CheckBoxListTile> {
  @override
  Widget build(BuildContext context) {
    var agentsProvider = Provider.of<AgentProvider>(context);
    return ListView.builder(
      itemBuilder: (context, i) => CheckboxListTile(
          activeColor: theme.addedMoreColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          title: Text(
            agentsProvider.agents[i].name,
            style: theme.text16bold,
          ),
          value: agentsProvider.agents[i].isChecked,
          secondary: CircleAvatar(
            backgroundImage: (agentsProvider.agents[i].photoUrl != null)
                ? NetworkImage(agentsProvider.agents[i].photoUrl)
                : null,
            child: agentsProvider.agents[i].photoUrl != null
                ? null
                : Icon(Icons.person),
          ),
          onChanged: (bool val) {
            setState(() {
              agentsProvider.agents[i].isChecked = val;
            });
          }),
      itemCount: agentsProvider.agents.length,
    );
  }
}
