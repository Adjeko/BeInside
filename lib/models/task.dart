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

  Task({this.id, this.icon, this.title, this.subtitle, this.category, this.group, this.description, this.created, this.heroTag});

  factory Task.fromAddDialog(title, subtitle, description){
    var uuid = Uuid();
    var rnd = Random();
    var _id = uuid.v1();
    
    return Task(
      id: _id,
      icon: "🤠🤡💀🤖👾👻🐱‍🏍🐱‍👤🐵🐶🐺🐱🦁🐯🦒🦒🦊🐻🐲🐸🐸🐼🐠🎃🎪🎞🎞🛒👑⚽⛳🏆☎💣"[rnd.nextInt("🤠🤡💀🤖👾👻🐱‍🏍🐱‍👤🐵🐶🐺🐱🦁🐯🦒🦒🦊🐻🐲🐸🐸🐼🐠🎃🎪🎞🎞🛒👑⚽⛳🏆☎💣".length)],
      title: title,
      subtitle: subtitle,
      category: "Test",
      group: "TestGroup",
      description: description,
      created: DateTime.now(),
      heroTag: _id,
    );
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
              break;
            default:
          }
        },
        key: ValueKey("Test"),
      ),
    );
  }

}
