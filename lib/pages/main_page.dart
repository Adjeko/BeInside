import 'package:beinside/pages/character_page.dart';
import 'package:beinside/pages/quest_page.dart';
import 'package:beinside/pages/room_page.dart';
import 'package:flutter/material.dart';

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
          _index = _controller.page.round();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Code'),
      ),
      body: PageView(
        controller: _controller,
        children: const [
          CharacterPage(),
          QuestPage(),
          RoomPage(),
        ],
      ),
    );
  }
}
