import 'dart:developer';

import 'package:beinside/pages/character/character_page.dart';
import 'package:beinside/pages/quests/quest_page.dart';
import 'package:beinside/pages/rooms/room_page.dart';
import 'package:beinside/widgets/floatingActionButton.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart' hide BottomNavigationBar;

class Layout extends StatefulWidget {
  @override
  LayoutState createState() => LayoutState();
}

class LayoutState extends State<Layout> {
  int _index = 0;

  final _controller = PageController();

  LayoutState() {
    _controller.addListener(() {
      if (_controller.page.round() != _index) {
        setState(() {
          log('Controller listener set index to: $_index');
          _index = _controller.page.round();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sample Code'), //TODO make dynamic aswell as icons
        ),
        body: buildPageView(),
        bottomNavigationBar: buildNavBar(),
        floatingActionButton: CustomFabButton(
          color: Colors.green,
          onPressed: () => log('Pressed FAB!'),
          icon: Icons.satellite,
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

  CurvedNavigationBar buildNavBar() {
    return CurvedNavigationBar(
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
    );
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
}
