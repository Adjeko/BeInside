import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddGroupDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.orange,
      child: Center(
        child: Column(
          children: <Widget>[
            Text("Fragen nach Gruppe und so"),
          ],
        ),
      ),
    );
  }
}