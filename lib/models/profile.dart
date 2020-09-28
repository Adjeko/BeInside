import 'package:beinside/models/group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:beinside/models/task.dart';

class Profile {
  final String id;
  final List<Task> tasks;
  final List<Group> groups;

  Profile({this.id, this.tasks, this.groups});

  factory Profile.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data;

    List<Task> _tasks = List<Task>();
    var _t = data['tasks'];
    for (int i = 0; i < _t.length; i++) {
      _tasks.add(Task.fromMap(_t[i]));
    }

    List<Group> _groups = List<Group>();
    var _g = data['groups'];
    for (int i = 0; i < _g.length; i++) {
      _groups.add(Group.fromMap(_g[i]));
    }

    return Profile(
      id: doc.documentID,
      tasks: _tasks,
      groups: _groups,
    );
  }

  static void joinGroup(FirebaseUser user, Group group) {
    List<String> _list = List<String>();
    _list.add(group.groupId);
    Firestore.instance.collection('player').document(user.uid).updateData({
      "groupIds": FieldValue.arrayUnion(_list),
    });
  }

  static void createPersonalTask(FirebaseUser user, Task task) {
    Firestore.instance
        .collection('player')
        .document(user.uid)
        .collection('tasks')
        .add(task.toFirestore());
  }

  static Stream<Profile> streamProfileList(FirebaseUser user) {
    if (user != null) {
      var _db = Firestore.instance;
      return _db
          .collection('player')
          .document(user.uid)
          .snapshots()
          .map((snap) => Profile.fromFirestore(snap));
    }

    return Stream.empty();
  }
}
