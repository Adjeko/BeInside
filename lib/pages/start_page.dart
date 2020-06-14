import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:beinside/pages/room_page.dart';
import 'package:beinside/pages/character_page.dart';
import 'package:beinside/pages/groupsearchpage.dart';
import 'package:beinside/pages/quest_page.dart';
import 'package:beinside/dialogs/addtaskdialog.dart';
import 'package:beinside/dialogs/addgroupdialog.dart';
import 'package:beinside/pages/settingspage.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _currentIndex = 1;

  List<Widget> _children = [
    CharacterPage(),
    QuestPage(),
    RoomPage(),
  ];

  List<String> testItems = {
    "Item1",
    "Item2",
    "Item3",
  }.toList();

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.arrow_back),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ));
              },
              child: Icon(Icons.more_vert)),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: onTabTapped,
        buttonBackgroundColor: Colors.blueGrey[100],
        backgroundColor: Colors.grey[100],
        animationCurve: Curves.easeOutCubic,
        height: 75,
        index: _currentIndex,
        items: [
          Column(
            children: <Widget>[
              Icon(Icons.accessibility_new),
              Text("Charakter"),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(Icons.mail),
              Text("Aufgaben"),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(Icons.developer_board),
              Text("Gruppen"),
            ],
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _buildBackground(),
          _buildGradientBox(context),
          _children[_currentIndex],
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    if (_currentIndex == 1) {
      return Transform.translate(
        offset: Offset(-20.0, -30.0),
        child: SpeedDial(
          animatedIcon: AnimatedIcons.add_event,
          animatedIconTheme: IconThemeData(size: 22.0),
          curve: Curves.bounceIn,
          tooltip: 'Erstelle Aufgabe',
          heroTag: 'aufgabespeeddial',
          backgroundColor: Colors.blue,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
              label: 'Aufgabe erstellen',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      AddTaskDialog(user: Provider.of<FirebaseUser>(context)),
                );
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
              label: 'Wiederholungen erstellen',
              onTap: () {},
            ),
            SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
              label: 'Meilensteine erstellen',
              onTap: () {},
            ),
          ],
        ),
      );
    } else if (_currentIndex == 2) {
      return Transform.translate(
        offset: Offset(-20.0, -30.0),
        child: SpeedDial(
          animatedIcon: AnimatedIcons.list_view,
          animatedIconTheme: IconThemeData(size: 22.0),
          curve: Curves.bounceIn,
          tooltip: 'Gruppen verwalten',
          heroTag: 'gruppespeeddial',
          backgroundColor: Colors.orange,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
              label: 'Gruppe erstellen',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      AddGroupDialog(user: Provider.of<FirebaseUser>(context)),
                );
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
              label: 'Neue Gruppen suchen',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupSearchPage(),
                    ));
              },
            ),
          ],
        ),
      );
    }
  }

  Widget _buildBackground() {
    return Container(
        decoration: BoxDecoration(
      color: Colors.grey[100],
    ));
  }

  Widget _buildGradientBox(BuildContext context) {
    return Positioned.fill(
      bottom: MediaQuery.of(context).size.height - 256,
      child: ClipPath(
        clipper: CharacterClipper(),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.yellow, Colors.red])),
          child: Stack(
            children: <Widget>[
              _buildCircles(200, 200, -100, -100, 0.2, Colors.white),
              _buildCircles(300, 300, 300, -100, 0.2, Colors.white),
              _buildCircles(300, 300, 50, 100, 0.2, Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircles(double height, double width, double x, double y,
      double opacity, Color color) {
    return Positioned(
      height: height,
      width: width,
      child: Transform.translate(
        offset: Offset(x, y),
        child: Opacity(
          opacity: opacity,
          child: Container(
            decoration: ShapeDecoration(
              shape: CircleBorder(),
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

class CharacterClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
