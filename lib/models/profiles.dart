import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:beinside/models/task.dart';

class Profiles {
   final String id;
   final String icon;
   final String title;
   final String subtitle;
   final String category;
   final String group;
   final String description;
   final Task tasks;

   Profiles({this.id, this.icon, this.title, this.subtitle, this.category, this.group, this.description, this.tasks});

   factory Profiles.fromFirestore(DocumentSnapshot doc) {
      Map data = doc.data;

      List<Task> _tasks = List.from(data['tasks']);

      return Profiles(
        id: doc.documentID,
        icon: data['icon'] ?? 'no icon found in firestore',
        title: data['title'] ?? 'no title found in firestore',
        subtitle: data['subtitle'] ?? 'no subtitle found in firestore',
        category: data['category'] ?? 'no category found in firestore',
        group: data['group'] ?? 'no group found in firestore',
        description: data['description'] ?? 'no description found in firestore',
      );
   }

   factory Profiles.fromMap(Map data){
      return Profiles(
        icon: data['icon'] ?? '☠',
        title: data['title'] ?? 'no title found in the map',
        subtitle: data['subtitle'] ?? 'no subtitle found in the map',
        category: data['category'] ?? 'no category found in firestore',
        group: data['group'] ?? 'no group found in firestore',
        description: data['description'] ?? 'no description found in firestore',
      );
   }

   static Stream<Profiles> streamTaskList(FirebaseUser user) {
     final Firestore _db = Firestore.instance;
     return _db.collection('profiles').document(user.uid).snapshots().map((snap) => Profiles.fromFirestore(snap));
   }
}