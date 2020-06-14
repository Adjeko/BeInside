import 'package:beinside/pages/groupdetailspage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

import 'package:beinside/models/task.dart';

class Group {
  final String id;
  final String author;
  final String icon;
  final String title;
  final String subtitle;
  final String description;
  final DateTime created;
  final String heroTag;
  final List<Task> tasks;

  Group(
      {this.id,
      this.author,
      this.icon,
      this.title,
      this.subtitle,
      this.description,
      this.created,
      this.heroTag,
      this.tasks});

  factory Group.fromAddDialog(user, title, subtitle, description) {
    var uuid = Uuid();
    var rnd = Random();
    var _id = uuid.v1();
    var rndInt = rnd.nextInt(23);

    return Group(
      id: _id,
      author: user.uid,
      icon: '✈🛰🛸🚀🚁🏟🏗🏘🏠⛩🛕🕋🏭🏫🏩🗼🏯🏥🗽🌉⛺🌅🌄💈'
          .substring(rndInt * 2, (rndInt + 1) * 2),
      title: title,
      subtitle: subtitle,
      description: description,
      created: DateTime.now(),
      heroTag: _id,
      tasks: null,
    );
  }

  factory Group.tutorialGroup() {
    var uuid = Uuid();
    var rnd = Random();
    var _id = uuid.v1();
    var rndInt = rnd.nextInt(23);

    return Group(
      id: _id,
      author: "Tutorial Author",
      icon: '✈🛰🛸🚀🚁🏟🏗🏘🏠⛩🛕🕋🏭🏫🏩🗼🏯🏥🗽🌉⛺🌅🌄💈'
          .substring(rndInt * 2, (rndInt + 1) * 2),
      title: "Tutorial Gruppe 1",
      subtitle: "Um dir zu zeigen wie Gruppen funktionieren",
      description: "und wie die Beschreibung aussieht",
      created: DateTime.now(),
      heroTag: _id,
      tasks: null,
    );
  }

  factory Group.fromMap(Map map) {
    Timestamp _t = map['created'];
    return Group(
      id: map['id'],
      author: map['author'],
      icon: map['icon'],
      title: map['title'],
      subtitle: map['subtitle'],
      description: map['description'],
      created: DateTime.fromMillisecondsSinceEpoch(_t.millisecondsSinceEpoch),
      heroTag: map['id'],
      tasks: null,
    );
  }

  static List<Group> fromFirestore(DocumentSnapshot snap) {
    List<Group> _groups = List<Group>();
      var _t = snap.data['groups'];

      for (int i = 0; i < _t.length; i++) {
        _groups.add(Group.fromMap(_t[i]));
      }

      return _groups;
  }

  Map<String, dynamic> asMap() {
    return {
      "id": this.id,
      "author": this.author,
      "icon": this.icon,
      "title": this.title,
      "subtitle": this.subtitle,
      "description": this.description,
      "created": this.created,
    };
  }

  static Stream<List<Group>> streamGroupSearchFromFirestore() {
    return Firestore.instance.collection('groups').document('groupSearch').snapshots().map((snap) => Group.fromFirestore(snap));
  }

  static void createGroupInFirestore(Group group) {
    Firestore.instance.collection('groups').document(group.id).setData(group.asMap());

    List<Map> _list = List<Map>();
    _list.add(group.asMap());
    Firestore.instance.collection('groups').document('groupSearch').updateData({
      "groups": FieldValue.arrayUnion(_list),
    });
  }

  Widget buildListTile(BuildContext context) {
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
                        builder: (context) => GroupDetailsPage(this, Provider.of<FirebaseUser>(context)),
                      ));
                },
                leading: Hero(
                  tag: id,
                  child: Text(icon),
                ),
                title: Text(title),
                subtitle: Text(subtitle),
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
        background: Container(color: Colors.green, child: Icon(Icons.check)),
        secondaryBackground:
            Container(color: Colors.red, child: Icon(Icons.cancel)),
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
  }
}
