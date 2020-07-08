import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:developer';

class BottomNavigationBar extends StatefulWidget {
  final int selectedIndex;

  const BottomNavigationBar({Key key, this.selectedIndex}) : super(key: key);

  @override
  _BottomNavigationBarState createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext ctx) {
    return CurvedNavigationBar(
      index: widget.selectedIndex,
      onTap: _onItemTapped,
      height: 60.0,
      items: <Widget>[
        Icon(Icons.accessibility_new, size: 30),
        Icon(Icons.check_circle, size: 30),
        Icon(Icons.group, size: 30),
      ],
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.grey[100],
      animationCurve: Curves.easeInOut,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Navigator.pushNamed(context, "/");
      log('Changed tab to index: $_selectedIndex');
    });
  }
}
