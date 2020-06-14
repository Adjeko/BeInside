import 'package:beinside/models/group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:beinside/models/task.dart';

class Profiles {
  final String id;
  final String username;
  final List<Task> tasks;
  final List<Group> groups;

  Profiles({this.id, this.username, this.tasks, this.groups});

  factory Profiles.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    List<Task> _tasks = List<Task>();
    var _t = doc.data['tasks'];
    for (int i = 0; i < _t.length; i++) {
      _tasks.add(Task.fromMap(_t[i]));
    }

    List<Group> _groups = List<Group>();
    var _g = doc.data['groups'];
    for (int i = 0; i < _g.length; i++) {
      _groups.add(Group.fromMap(_g[i]));
    }

    return Profiles(
      id: doc.documentID,
      username: data['username'] ?? "no username found in document",
      tasks: _tasks,
      groups: _groups,
    );
  }

  factory Profiles.fromMap(Map data) {
    return Profiles(
      id: data['id'],
      username: data['username'] ?? "no username found in document",
    );
  }

  static void createNewProfileInFirestore(FirebaseUser user) {
    List<Map> _tasks = List<Map>();
    _tasks.add(Task.tutorialTask().asMap());

    List<Map> _groups = List<Map>();
    _groups.add(Group.tutorialGroup().asMap());

    Firestore.instance.collection('profiles').document(user.uid).setData({
      'id': user.uid,
      'username': 'TestUser',
      'tasks': _tasks,
      'groups': _groups,
    });
  }

  static void joinGroup(FirebaseUser user, Group group) {
    List<Map> _list = List<Map>();
    _list.add(group.asMap());
    Firestore.instance.collection('profiles').document(user.uid).updateData({
      "groups": FieldValue.arrayUnion(_list),
    });
  }

  static void writeTaskToFirestore(FirebaseUser user, Task task) {
    List<Map> _list = List<Map>();
    _list.add(task.asMap());
    Firestore.instance.collection('profiles').document(user.uid).updateData({
      "tasks": FieldValue.arrayUnion(_list),
    });
  }

  static Stream<Profiles> streamProfileList(FirebaseUser user) {
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
