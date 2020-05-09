
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'models/taskList.dart';
import 'services/authentication.dart';
import 'services/admob.dart';
import 'services/remoteconfiguration.dart';
import 'widgets/loginCard.dart';

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
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  final auth = FirebaseAuth.instance;

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: LoginCard()
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: Authentication.twitterSignIn,
        // onPressed: () {FirebaseAuth.instance.signInWithEmailAndPassword(email: "adjeko88@gmail.com", password: "hp1955"); },
        tooltip: 'Login',
        child: Icon(Icons.security),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
