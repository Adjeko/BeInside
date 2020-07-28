import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

import 'package:beinside/pages/tutorialpage.dart';
import 'package:beinside/pages/start_page.dart';
import 'package:beinside/services/authentication.dart';
import 'package:beinside/models/profiles.dart';

class EmailLoginDialog extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  EmailLoginDialog();

  Future<String> _authLogin(LoginData data) {
    Authentication.signInWithEmail(data.name, data.password);

    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _authSignup(LoginData data) async {
    FirebaseUser user =
        await Authentication.createUserWithEmail(data.name, data.password);
    // Profiles.createNewProfileInFirestore(user);

    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: FlutterLogin(
        title: 'BeInside',
        logo: "assets/minion.jfif",
        onLogin: _authLogin,
        onSignup: _authSignup,
        onSubmitAnimationCompleted: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StartPage(),
              ));
        },
        onRecoverPassword: _recoverPassword,
      ),
    );
  }
}
