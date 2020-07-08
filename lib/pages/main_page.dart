import 'dart:developer';

import 'package:beinside/pages/character_page.dart';
import 'package:beinside/pages/quest_page.dart';
import 'package:beinside/pages/room_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart' hide BottomNavigationBar;

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _index = 0;

  final _controller = PageController();

  MainPageState() {
    _controller.addListener(() {
      if (_controller.page.round() != _index) {
        setState(() {
          log('Controller listener set index to: $_index');
          _index = _controller.page.round();
        });
      }
    });
  }

  void _showPageIndex(int index) {
    setState(() {
      _index = index;
    });
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sample Code'),
        ),
        body: buildPageView(),
        bottomNavigationBar: CurvedNavigationBar(
          index: _index,
          onTap: _showPageIndex,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.accessibility_new, size: 30),
            Icon(Icons.check_circle, size: 30),
            Icon(Icons.keyboard, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.grey[100],
        ));
  }

  Widget buildPageView() {
    return PageView(
      controller: _controller,
      children: const [
        CharacterPage(),
        QuestPage(),
        RoomPage(),
      ],
    );
  }
}
