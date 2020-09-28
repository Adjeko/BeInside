import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:beinside/models/group.dart';
import 'package:beinside/models/profile.dart';

class GroupDetailsPage extends StatelessWidget {
  final Group _group;
  final FirebaseUser _user;

  GroupDetailsPage(this._group, this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.arrow_back),
        actions: <Widget>[Icon(Icons.more_vert)],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Das ist der Name"),
            Hero(tag: _group.heroTag, child: Text(_group.icon)),
            Text("Author"),
            Text("Anzahl der Mitglieder"),
            Text("Beschreibung"),
            RaisedButton(
              elevation: 5,
              child: Text("Beitreten"),
              onPressed: () {
                Profile.joinGroup(_user, _group);
              },
            ),
            RaisedButton(
              elevation: 5,
              child: Text("Austreten"),
              onPressed: () {
                Profile.leaveGroup(_user, _group);
              },
            ),
            RaisedButton(
              elevation: 5,
              child: Text("Löschen"),
              onPressed: () {
                Group.deleteGroupInFirestore(_group);
              },
            ),
          ],
        ),
      ),
    );
  }
}
