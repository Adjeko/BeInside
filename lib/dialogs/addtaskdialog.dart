import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:beinside/models/task.dart';

class AddTaskDialog extends StatefulWidget {
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title;
  String _subtitle;
  String _description;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.blue,
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
                    if(value.isEmpty) {
                      return "Bitte gib einen Titel an.";
                    }
                    return null;},
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
                    if(value.isEmpty) {
                      return "Bitte gib einen Untertitel an.";
                    }
                    return null;},
                ),
              ),
              Text("Beschreibung"),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  onSaved: (value) {
                    _description = value;
                  },
                  validator: (value) {return null;},
                ),
              ),
              RaisedButton(
                onPressed: () {
                  if(_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Task resultTask = Task.fromAddDialog(_title, _subtitle, _description);

                    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Aufgabe erstellt")));
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
