import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:beinside/models/profiles.dart';
import 'package:provider/provider.dart';

class QuestPage extends StatelessWidget {
  const QuestPage();

  @override
  Widget build(BuildContext context) {
    // var user = Provider.of<FirebaseUser>(context);

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
              child: Consumer<FirebaseUser>(
                builder: (context, user, child) {
                  return StreamBuilder<Profiles>(
                    stream: Profiles.streamTaskList(user),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      Profiles profile = snapshot.data;

                      return ListView.builder(
                        itemCount: snapshot.data.tasks.length,
                        itemBuilder: (context, i) {
                          return snapshot.data.tasks[i].buildListTile(context);
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
  }
}
