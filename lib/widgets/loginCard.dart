import 'package:beinside/dialogs/emaillogindialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:beinside/services/authentication.dart';

class LoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SignInButton(
              Buttons.Email,
              text: "Sign up with Email",
              mini: false,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => EmailLoginDialog(),
                );
              },
            ),
            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              mini: false,
              onPressed: Authentication.googleSignIn,
            ),
            SignInButton(
              Buttons.Facebook,
              text: "Sign up with Facebook",
              mini: false,
              onPressed: Authentication.facebookSignIn,
            ),
            SignInButton(
              Buttons.Twitter,
              text: "Sign up with Twitter",
              mini: false,
              onPressed: Authentication.twitterSignIn,
            ),
          ],
        ),
      ),
    );
  }
}
