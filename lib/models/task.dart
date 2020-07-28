import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

import 'package:beinside/pages/questdetailspage.dart';

class Task {
  final String id;
  final String icon;
  final String title;
  final String subtitle;
  final String category;
  final String group;
  final String description;
  final DateTime created;
  final String heroTag;

  Task(
      {this.id,
      this.icon,
      this.title,
      this.subtitle,
      this.category,
      this.group,
      this.description,
      this.created,
      this.heroTag});

  factory Task.fromAddDialog(title, subtitle, description) {
    var uuid = Uuid();
    var rnd = Random();
    var _id = uuid.v1();
    var rndInt = rnd.nextInt(35);

    return Task(
      id: _id,
      icon:
          '🤠🤡💀🤖👾👻🐱‍🏍🐱‍👤🐵🐶🐺🐱🦁🐯🦒🦊🐻🐲🐸🐼🐠🎃🎪🎞🎞🛒👑⚽⛳🏆☎💣'
              .substring(rndInt * 2, (rndInt + 1) * 2),
      title: title,
      subtitle: subtitle,
      category: "Test",
      group: "TestGroup",
      description: description,
      created: DateTime.now(),
      heroTag: _id,
    );
  }

  factory Task.fromMap(Map taskMap) {
    Timestamp _t = taskMap['created'];
    return Task(
      id: taskMap['id'],
      icon: taskMap['icon'],
      title: taskMap['title'],
      subtitle: taskMap['subtitle'],
      category: taskMap['category'],
      group: taskMap['group'],
      description: taskMap['description'],
      created: DateTime.fromMillisecondsSinceEpoch(_t.millisecondsSinceEpoch),
      heroTag: taskMap['id'],
    );
  }

  factory Task.tutorialTask() {
    var uuid = Uuid();
    var rnd = Random();
    var _id = uuid.v1();
    var rndInt = rnd.nextInt(35);

    return Task(
      id: _id,
      icon:
          '🤠🤡💀🤖👾👻🐱‍🏍🐱‍👤🐵🐶🐺🐱🦁🐯🦒🦊🐻🐲🐸🐼🐠🎃🎪🎞🎞🛒👑⚽⛳🏆☎💣'
              .substring(rndInt * 2, (rndInt + 1) * 2),
      title: 'Das ist eine Tutorial Aufgabe',
      subtitle: "Sie zeigt dir wie Aufgaben funktionieren",
      category: "Tutorial Kategorie",
      group: "Tutorial Gruppe",
      description: "Und wie eine Beschreibung aussieht",
      created: DateTime.now(),
      heroTag: _id,
    );
  }

  Map asMap() {
    return {
      "id": this.id,
      "icon": this.icon,
      "title": this.title,
      "subtitle": this.subtitle,
      "category": this.category,
      "group": this.group,
      "description": this.description,
      "created": this.created
    };
  }

  void removeFromFirebase(String userId) {
    List<Map> tmp = List<Map>();
    tmp.add(this.asMap());
    Firestore.instance.collection('profiles').document(userId).updateData({
      "tasks": FieldValue.arrayRemove(tmp),
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
                        builder: (context) => QuestDetailsPage(this),
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
              FirebaseUser user =
                  Provider.of<FirebaseUser>(context, listen: false);
              removeFromFirebase(user.uid);
              break;
            default:
          }
        },
        key: ValueKey("Test"),
      ),
    );
  }
}
