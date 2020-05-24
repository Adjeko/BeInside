import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestDetailsPage extends StatelessWidget {

  final String _heroTag;
  final IconData _icon;

  QuestDetailsPage(this._heroTag, this._icon);

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
            Text("Das ist der Titel"),
            Hero(
              tag: _heroTag,
              child: Icon(_icon)),
            Text("Kategorie"),
            Text("Aus der Gruppe"),
            Text("Fortschritt"),
            Text("Beschreibung"),
          ],
        ),
      ),
    );
  }

}