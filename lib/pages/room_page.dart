import 'package:beinside/models/profiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:beinside/pages/groupdetailspage.dart';
import 'package:beinside/models/group.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoomPage extends StatelessWidget {
  List<String> testGroups = {
    "Group1",
    "Group2",
    "Group3",
  }.toList();
  final List<IconData> testIcons = {
    Icons.kitchen,
    Icons.pool,
    Icons.beach_access,
  }.toList();

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        children: <Widget>[
          Opacity(
            opacity: 0.3,
            child: Image.network(
                "https://images.unsplash.com/photo-1483428400520-675ef69a3bc4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80"),
          ),
          Container(
            child: Expanded(
              child: Consumer<FirebaseUser>(
                builder: (context, user, child) {
                  return StreamBuilder<Profiles>(
                    stream: Profiles.streamProfileList(user),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      Profiles profile = snapshot.data;

                      return ListView.builder(
                        itemCount: profile.groups.length,
                        itemBuilder: (context, i) {
                          return profile.groups[i].buildListTile(context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );



    return Center(
      child: ListView.builder(
          itemCount: testGroups.length,
          itemBuilder: (context, i) {
            return Card(
                child: Material(
                    elevation: 5,
                    child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    GroupDetailsPage(Group.tutorialGroup(), Provider.of<FirebaseUser>(context)),
                              ));
                        },
                        leading: Icon(testIcons[i]),
                        title: Text(testGroups[i]))));
          }),
    );
  }
}
