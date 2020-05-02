import 'package:beinside/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'models/taskList.dart';

import 'package:firebase_admob/firebase_admob.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signInWithEmailAndPassword(email: "adjekoooo@gmail.com", password: "hp1955");
    // Authentication.googleSignIn();
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-3966289857724701~2395283496");
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged
        ),
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

  

  

  void initAd() {
    BannerAd ba = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      // adUnitId: "ca-app-pub-3966289857724701/1365558265",
      size: AdSize.smartBanner,
      targetingInfo: MobileAdTargetingInfo(keywords: <String>['flutterio', 'beautiful apps'],
          contentUrl: 'https://flutter.io',
          birthday: DateTime.now(),
          childDirected: false,
          designedForFamilies: false,
          gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
          testDevices: <String>[],
        ),
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );

    ba..load()..show(
      anchorOffset: 100.0,
      anchorType: AnchorType.bottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    initAd();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(
                  child: Text("Google"),
                  onPressed: Authentication.googleSignIn, 
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(
                  child: Text("Facebook"),
                  onPressed: Authentication.facebookSignIn, 
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(
                  child: Text("Twitter"),
                  onPressed: Authentication.twitterSignIn, 
                ),
              ),
            ],
          ),
          Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(
                  child: Text("Sign Out"),
                  onPressed: Authentication.signOut, 
                ),
              ),
          Center(
            child: 
              (() {
                  if (user != null) {
                  return StreamBuilder<TaskList> (
                    stream: TaskList.streamTaskList(user),
                    builder: (context, snapshot) {
                      TaskList list = snapshot.data;

                      if (list != null) {
                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Text("${list.icon} | ${list.title} | ${list.subtitle}");
                          },
                        );
                      } else {
                        return Text("keine Liste erhalten");
                      }
                    },
                  );
                } else {
                  return Text("kein User angemeldet");
                }
              }())
          ),
        ],
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
