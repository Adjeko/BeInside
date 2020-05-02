import 'package:beinside/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'models/taskList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signInWithEmailAndPassword(email: "adjekoooo@gmail.com", password: "hp1955");
    // Authentication.googleSignIn();
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  final auth = FirebaseAuth.instance;

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(
                  child: Text("Google"),
                  onPressed: Authentication.googleSignIn, 
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(
                  child: Text("Facebook"),
                  onPressed: Authentication.facebookSignIn, 
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(
                  child: Text("Twitter"),
                  onPressed: Authentication.twitterSignIn, 
                ),
              ),
            ],
          ),
          Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(
                  child: Text("Sign Out"),
                  onPressed: Authentication.signOut, 
                ),
              ),
          Center(
            child: 
              (() {
                  if (user != null) {
                  return StreamBuilder<TaskList> (
                    stream: TaskList.streamTaskList(user),
                    builder: (context, snapshot) {
                      TaskList list = snapshot.data;

                      if (list != null) {
                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Text("${list.icon} | ${list.title} | ${list.subtitle}");
                          },
                        );
                      } else {
                        return Text("keine Liste erhalten");
                      }
                    },
                  );
                } else {
                  return Text("kein User angemeldet");
                }
              }())
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Authentication.twitterSignIn,
        // onPressed: () {FirebaseAuth.instance.signInWithEmailAndPassword(email: "adjeko88@gmail.com", password: "hp1955"); },
        tooltip: 'Login',
        child: Icon(Icons.security),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
