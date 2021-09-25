// ignore: camel_case_types
import 'package:contact/Models/ContactModel.dart';
import 'package:flutter/material.dart';

class SearchContact extends SearchDelegate<String> {
  List<ContactModel> ls;

  SearchContact({
    this.ls,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext contexntext) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(contexntext).pop();
      },
    );
    // throw UnimplementedError();
  }

  ContactModel resultChoosen;
  @override
  Widget buildResults(BuildContext context) {
    return resultChoosen == null
        ? Center(
            child: Text("No Result Found"),
          )
        : GestureDetector(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => MainStoreScreen(
              //       shopData: resultChoosen,
              //       user: user,
              //       userInfo: usrInfo,
              //       userLat: lat,
              //       userlng: lng,
              //     ),
              //   ),
              // );
            },
            child: Text(resultChoosen.name));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? [...ls]
        : ls.where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()) ||
            element.companyName.toLowerCase().contains(query.toLowerCase()));

    return suggestionList.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  size: 65,
                ),
                Center(
                  child: Text(
                    "No result found.\nCheck spelling and try again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                onTap: () {
                  resultChoosen = suggestionList.elementAt(index);
                  showResults(context);
                },
                title: RichText(
                  text: TextSpan(
                      text: suggestionList
                          .elementAt(index)
                          .name
                          .substring(0, query.length),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      children: [
                        TextSpan(
                          text: suggestionList.elementAt(index).name.substring(
                              query.length,
                              suggestionList.elementAt(index).name.length),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        )
                      ]),
                ),
                subtitle: RichText(
                  text: TextSpan(
                      text: suggestionList
                          .elementAt(index)
                          .email
                          .substring(0, query.length),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      children: [
                        TextSpan(
                          text: suggestionList.elementAt(index).email.substring(
                              query.length,
                              suggestionList.elementAt(index).email.length),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        )
                      ]),
                ),
              ),
            ),
          );
  }
}
