import 'package:beinside/pages/loginpage.dart';
import 'package:beinside/pages/main_page.dart';
import 'package:beinside/pages/start_page.dart';
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
          '/': (context) => MainPage(),
          '/login': (context) => LoginPage(),
        },
      ),
    );
  }
}
