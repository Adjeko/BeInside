import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:beinside/models/task.dart';

class QuestDetailsPage extends StatelessWidget {

  final Task _task;

  QuestDetailsPage(this._task);

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
            Text("Title: " + _task.title),
            Hero(
              tag: _task.heroTag,
              child: Text(_task.icon)),
            Text("Kategory: " + _task.category),
            Text("Gruppe: " + _task.group),
            Text("Fortschritt: "),
            Text("Beschreibung: " + _task.description),
          ],
        ),
      ),
    );
  }

}