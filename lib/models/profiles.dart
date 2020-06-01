import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:beinside/models/task.dart';

class Profiles {
  final String id;
  final String icon;
  final String title;
  final String subtitle;
  final String category;
  final String group;
  final String description;
  final List<Task> tasks;

  Profiles(
      {this.id,
      this.icon,
      this.title,
      this.subtitle,
      this.category,
      this.group,
      this.description,
      this.tasks});

  factory Profiles.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    List<Task> _tasks = List<Task>();
    var _t = doc.data['tasks'];

    for(int i = 0; i < _t.length; i++) {
      _tasks.add(Task.fromMap(_t[i]));
    }

    return Profiles(
      id: doc.documentID,
      icon: data['icon'] ?? 'no icon found in firestore',
      title: data['title'] ?? 'no title found in firestore',
      subtitle: data['subtitle'] ?? 'no subtitle found in firestore',
      category: data['category'] ?? 'no category found in firestore',
      group: data['group'] ?? 'no group found in firestore',
      description: data['description'] ?? 'no description found in firestore',
      tasks: _tasks,
    );
  }

  factory Profiles.fromMap(Map data) {
    return Profiles(
      icon: data['icon'] ?? '☠',
      title: data['title'] ?? 'no title found in the map',
      subtitle: data['subtitle'] ?? 'no subtitle found in the map',
      category: data['category'] ?? 'no category found in firestore',
      group: data['group'] ?? 'no group found in firestore',
      description: data['description'] ?? 'no description found in firestore',
    );
  }

  

  static void writeTaskToFirestore(FirebaseUser user, Task task) {
    List<Map> _list = List<Map>();
    _list.add(task.asMap());
    Firestore.instance.collection('profiles').document(user.uid).updateData({
      "tasks": FieldValue.arrayUnion(_list),
    });
  }

  static Stream<Profiles> streamTaskList(FirebaseUser user) {
    if (user != null) {
      var _db = Firestore.instance;
      return _db
          .collection('profiles')
          .document(user.uid)
          .snapshots()
          .map((snap) => Profiles.fromFirestore(snap));
    }
  }
}
