import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:beinside/models/group.dart';

class AddGroupDialog extends StatefulWidget {

  final FirebaseUser user;

  const AddGroupDialog({Key key, this.user}) : super(key: key);

  @override
  _AddGroupDialogState createState() => _AddGroupDialogState(user);
}

class _AddGroupDialogState extends State<AddGroupDialog> {
  String _title;
  String _subtitle;
  String _description;

  FirebaseUser _user;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _AddGroupDialogState(this._user);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.orange,
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text("Titel"),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  onSaved: (value) {
                    _title = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Bitte gib einen Titel an.";
                    }
                    return null;
                  },
                ),
              ),
              Text("Untertitel"),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  onSaved: (value) {
                    _subtitle = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Bitte gib einen Untertitel an.";
                    }
                    return null;
                  },
                ),
              ),
              Text("Beschreibung"),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  onSaved: (value) {
                    _description = value;
                  },
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Group resultGroup =
                        Group.fromAddDialog(_user, _title, _subtitle, _description);

                    Group.createGroupInFirestore(resultGroup);
                    Navigator.pop(context);
                  }
                },
                child: Text("Erstellen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
