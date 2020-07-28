import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:beinside/pages/login/loginCard.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoginCard(),
      ),
    );
  }
}
