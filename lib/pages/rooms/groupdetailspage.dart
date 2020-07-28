import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupDetailsPage extends StatelessWidget {
  final String _heroTag;
  final IconData _icon;

  GroupDetailsPage(this._heroTag, this._icon);

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
            Hero(
              tag: _heroTag,
              child: Icon(_icon)),
            Text("Author"),
            Text("Anzahl der Mitglieder"),
            Text("Beschreibung"),
            RaisedButton(
              elevation: 5,
              child: Text("Beitreten"),
              onPressed: () {},
              ),
          ],
        ),
      ),
    );
  }
}