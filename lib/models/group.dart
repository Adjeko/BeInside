import 'package:cloud_firestore/cloud_firestore.dart';
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

  static void createGroupInFirestore(Group group) {
    Firestore.instance
        .collection('groups')
        .document(group.id)
        .setData(group.asMap());
  }
}
