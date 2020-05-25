import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:beinside/models/profiles.dart';

class QuestDetailsPage extends StatelessWidget {

  final String _heroTag;
  final Profiles _profile;

  QuestDetailsPage(this._profile, this._heroTag);

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
            Text("Title: " + _profile.title),
            Hero(
              tag: _heroTag,
              child: Text(_profile.icon)),
            Text("Kategory: " + _profile.category),
            Text("Gruppe: " + _profile.group),
            Text("Fortschritt: "),
            Text("Beschreibung: " + _profile.description),
          ],
        ),
      ),
    );
  }

}