import 'package:beinside/pages/login/loginpage.dart';
import 'package:beinside/pages/layout.dart';
import 'package:beinside/pages/quests/questdetailspage.dart';
import 'package:beinside/pages/settings/settingspage.dart';
import 'package:beinside/pages/tutorial/tutorialpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // RemoteConfiguration remoteConfig = RemoteConfiguration();
    // remoteConfig.init();

    // Admob admob = Admob();
    // admob.init();
    // admob.initAd();

    //only allow portrait orientation
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
        routes: {
          '/': (context) => Layout(),
          '/login': (context) => LoginPage(),
          '/tutorial': (context) => TutorialPage(),
          '/settings': (context) => SettingsPage()
          //TODO add quest, rooms and character pages
        },
      ),
    );
  }
}
