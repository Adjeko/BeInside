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

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Dismissible(
                      child: Container(
                        child: Card(
                          child: Material(
                            elevation: 5,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          QuestDetailsPage(profile, "quest"),
                                    ));
                              },
                              leading: Hero(
                                tag: "quest",
                                child: Text(profile.icon),
                              ),
                              title: Text(profile.title),
                              subtitle: Text(profile.subtitle),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      background: Container(
                          color: Colors.green, child: Icon(Icons.check)),
                      secondaryBackground: Container(
                          color: Colors.red, child: Icon(Icons.cancel)),
                      onDismissed: (direction) {
                        switch (direction) {
                          case DismissDirection.startToEnd:
                            break;
                          case DismissDirection.endToStart:
                            break;
                          default:
                        }
                      },
                      key: ValueKey("Test"),
                    ),
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
