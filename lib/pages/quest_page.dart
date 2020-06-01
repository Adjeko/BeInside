import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:beinside/pages/questdetailspage.dart';
import 'package:beinside/models/profiles.dart';
import 'package:provider/provider.dart';

class QuestPage extends StatelessWidget {
  final List<String> testItems = {
    "Item1",
    "Item2",
    "Item3",
  }.toList();
  final List<IconData> testIcons = {
    Icons.laptop_windows,
    Icons.videogame_asset,
    Icons.router,
  }.toList();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);

    return Center(
      child: Column(
        children: <Widget>[
          Opacity(
            opacity: 0.3,
            child: Image.network(
                "https://blog.strava.com/wp-content/uploads/2017/03/FitFreshillustration.png"),
          ),
          Container(
            child: Expanded(
              child: StreamBuilder<Profiles>(
                stream: Profiles.streamTaskList(user),
                builder: (context, snapshot) {
                  Profiles profile = snapshot.data;

                  return Text("Test");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
