import 'package:beinside/pages/quest_page.dart';
import 'package:beinside/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:beinside/models/taskList.dart';
import 'package:beinside/services/authentication.dart';
import 'package:beinside/services/admob.dart';
import 'package:beinside/services/remoteconfiguration.dart';
import 'package:beinside/widgets/loginCard.dart';

import 'package:beinside/pages/room_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signInWithEmailAndPassword(email: "adjekoooo@gmail.com", password: "hp1955");
    // Authentication.googleSignIn();
    RemoteConfiguration remoteConfig = RemoteConfiguration();
    remoteConfig.init();

    // Admob admob = Admob();
    // admob.init();
    // admob.initAd();

    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StartPage(),
      ),
    );
  }
}
