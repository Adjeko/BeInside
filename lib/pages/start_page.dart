import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:beinside/pages/room_page.dart';
import 'package:beinside/pages/character_page.dart';
import 'package:beinside/pages/quest_page.dart';

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
        actions: <Widget>[Icon(Icons.more_vert)],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.accessibility_new),
            title: new Text("Charakter"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text("Aufgaben"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.developer_board),
            title: new Text("Gruppen"),
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

  FloatingActionButton _buildFloatingActionButton() {
    if (_currentIndex == 1) {
      return new FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      );
    } else if (_currentIndex == 2) {
      return new FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
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
