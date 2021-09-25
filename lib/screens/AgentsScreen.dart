import 'package:contact/Provider/agentProvider.dart';
import 'package:contact/main.dart';
import 'package:contact/screens/DrawerScreen.dart';
import 'package:contact/screens/addAgentScreen.dart';
import 'package:contact/widgets/CustomAppbar.dart';
import 'package:contact/widgets/slidableWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AgentsScreen extends StatefulWidget {
  @override
  _AgentsScreenState createState() => _AgentsScreenState();
}

class _AgentsScreenState extends State<AgentsScreen> {
  final TextEditingController _searchController = new TextEditingController();
  @override
  void initState() {
    Provider.of<AgentProvider>(context, listen: false).getAllAgents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var agentProvider = Provider.of<AgentProvider>(context);
    return Scaffold(
      backgroundColor:
          theme.darkMode ? theme.colorBackgroundGray : theme.colorBackground,
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.addedColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddAgentScreen(
                    agentModel: null,
                    isEditing: false,
                  )));
        },
        child: Icon(
          Icons.add,
          size: 25.sp,
          color: theme.colorPrimary,
        ),
      ),
      appBar: customAppBar(context),
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
                  // width: 75.w,
                  child: TextFormField(
                    style: theme.robotoTextprimary,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                      fillColor: theme.colorGrey,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorPrimary),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorPrimary),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorPrimary),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.colorPrimary),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: theme.colorPrimary,
                      ),
                      hintText: 'Search Agent',
                      hintStyle: GoogleFonts.robotoSlab(
                          fontSize: 16, color: theme.colorPrimary),
                    ),
                    controller: _searchController,
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
                    onPressed: () {})
              ],
            ),
            SizedBox(height: 3.h),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, i) => Column(
                  children: [
                    SlidableWidget(
                      deleteFunction: () async {
                        await agentProvider
                            .deleteAgent(agentProvider.agents[i]);
                      },
                      editFunction: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddAgentScreen(
                                  agentModel: agentProvider.agents[i],
                                  isEditing: true,
                                )));
                      },
                      child: Container(
                        //color: Colors.red,
                        width: 90.w,
                        margin: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Card(
                          shadowColor: theme.colorPrimary,
                          elevation: 3,
                          color: theme.colorBackground,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.zero,
                          child: ListTile(
                            title: Text(agentProvider.agents[i].name,
                                style: theme.text14bold),
                            subtitle: Text(
                              agentProvider.agents[i].email,
                              style: theme.text14primary,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: theme.colorPrimary,
                              backgroundImage:
                                  agentProvider.agents[i].photoUrl != null
                                      ? NetworkImage(
                                          agentProvider.agents[i].photoUrl)
                                      : null,
                              child: agentProvider.agents[i].photoUrl != null
                                  ? null
                                  : Center(
                                      child: Text(
                                        agentProvider.agents[i].name[0]
                                            .toUpperCase(),
                                        style: theme.text20bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider()
                  ],
                ),
                itemCount: agentProvider.agents.length,
              ),
            )
          ],
        ),
      ),
      drawer: DrawerScreen(),
    );
  }
}
