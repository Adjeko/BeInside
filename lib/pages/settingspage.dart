import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:beinside/services/authentication.dart';
import 'package:beinside/pages/loginpage.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Hier kommen viele krasse Sachen hin... AGB 🤮"),
          RaisedButton(
            child: Text("Abmelden"),
            onPressed: () {
              Authentication.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
          ),
        ],
      )),
    );
  }
}
