import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskList {
   final String id;
   final String icon;
   final String title;
   final String subtitle;

   TaskList({this.id, this.icon, this.title, this.subtitle});

   factory TaskList.fromFirestore(DocumentSnapshot doc) {
     Map data = doc.data;

      return TaskList(
        id: doc.documentID,
        icon: data['icon'] ?? 'no icon found in firestore',
        title: data['title'] ?? 'no title found in firestore',
        subtitle: data['subtitle'] ?? 'no subtitle found in firestore',
      );
   }

   factory TaskList.fromMap(Map data){
      return TaskList(
        icon: data['icon'] ?? '☠',
        title: data['title'] ?? 'no title found in the map',
        subtitle: data['subtitle'] ?? 'no subtitle found in the map',
      );
   }

   static Stream<TaskList> streamTaskList(FirebaseUser user) {
     final Firestore _db = Firestore.instance;
     return _db.collection('taskLists').document(user.uid).snapshots().map((snap) => TaskList.fromFirestore(snap));
   }
}