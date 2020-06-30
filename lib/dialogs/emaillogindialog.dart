import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

import 'package:beinside/pages/start_page.dart';
import 'package:beinside/services/authentication.dart';

class EmailLoginDialog extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  EmailLoginDialog();

  Future<String> _authLogin(LoginData data) {
    Authentication.signInWithEmail(data.name, data.password);

    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _authSignup(LoginData data) {
    Authentication.createUserWithEmail(data.name, data.password);

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

// Stack(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.only(
//               top: 66.0 + 16.0,
//               bottom: 16.0,
//               left: 16.0,
//               right: 16.0,
//             ),
//             margin: EdgeInsets.only(top: 66.0),
//             decoration: new BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.rectangle,
//               borderRadius: BorderRadius.circular(16.0),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 10.0,
//                   offset: const Offset(0.0, 10.0),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min, // To make the card compact
//               children: <Widget>[
//                 Text(
//                   "BeInside Email Anmeldung",
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(height: 16.0),
//                 Text(
//                   "Melde dich mit deiner Email an",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 16.0,
//                   ),
//                 ),
//                 SizedBox(height: 24.0),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: FlatButton(
//                     onPressed: () {
//                       Navigator.of(context).pop(); // To close the dialog
//                     },
//                     child: Text("Anmelden"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             left: 16.0,
//             right: 16.0,
//             child: CircleAvatar(
//               child: ClipOval(
//                 child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR7ddvoevlX5vr4fwi1jkB0xQ0v9UXzkL0XK4iFXg9V82CoWI3l&usqp=CAU")),
//               backgroundColor: Colors.blueAccent,
//               radius: 66.0,
//             ),
//           ),
//         ],
//       ),
