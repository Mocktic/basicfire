import 'package:contact/Models/AgentModel.dart';
import 'package:contact/screens/addAgentScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_functions/cloud_functions.dart' as cloud;

class AgentProvider with ChangeNotifier {
  List<AgentsModel> _agents = [];

  List<AgentsModel> get agents {
    return [..._agents];
  }

  Future<void> getAllAgents() async {
    _agents = [];
    final data = await FirebaseDatabase.instance
        .reference()
        .child("employee")
        .orderByChild("Admin ID")
        .equalTo(FirebaseAuth.instance.currentUser.uid)
        .once();
    print(data.value);
    final snap = data.value as Map;
    if (snap != null) {
      snap.forEach(
        (key, value) {
          _agents.add(
            AgentsModel(
                email: value['email'],
                isChecked: false,
                name: value['Name'],
                phone: value['Phone No'],
                photoUrl: value['photoUrl'],
                userId: key,
                createdDate: DateTime.now(),
                gender:
                    value['gender'] == "Male" ? Gender.Male : Gender.Female),
          );
        },
      );
    }
    notifyListeners();
  }

  void addAgent(AgentsModel agent) {
    _agents.add(agent);
    notifyListeners();
  }

  Future<void> deleteAgent(AgentsModel key) async {
    // Agentuid
    final cloud.HttpsCallable callable =
        cloud.FirebaseFunctions.instance.httpsCallable(
      'createAgent',
    );
    await callable.call({
      "Agentuid": key.userId,
    }).catchError((onError) {
      Fluttertoast.showToast(msg: "Something went wrong");
    });
    await FirebaseDatabase.instance
        .reference()
        .child("employee")
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(key.userId)
        .remove();
    _agents.remove(key);
  }
}
