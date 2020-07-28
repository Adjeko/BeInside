import 'package:beinside/pages/layout.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class TutorialPage extends StatelessWidget {
  List<PageViewModel> pages = [
    PageViewModel(
      title: "Erste Tutorial Seite",
      body: "Banana Ninja",
      image: Center(
        child: Image.network(
            "https://s1.thcdn.com/productimg/1600/1600/11489653-1374492597223451.jpg",
            height: 175.0),
      ),
    ),
    PageViewModel(
      title: "Zweite Tutorial Seite",
      body: "Sneaky Minion",
      image: Center(
        child: Image.network(
            "https://www.musikexpress.de/wp-content/uploads/2015/08/05/09/Minions.jpg",
            height: 175.0),
      ),
      footer: RaisedButton(
        onPressed: () {
          // On button presed
        },
        child: const Text("Let's Go !"),
      ),
    ),
    PageViewModel(
      title: "Tutorial Abschluss",
      bodyWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Click on "),
          Icon(Icons.edit),
          Text("to edit a post"),
        ],
      ),
      image: Center(
        child: Image.network(
            "https://www.gameloft.com/minisites/p/index.php/minionrush_faq/assets/img/high-res/minion_writing.png",
            height: 175.0),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutorial Page"),
      ),
      body: Center(
        child: IntroductionScreen(
          pages: pages,
          done: const Text("Let's GO",
              style: TextStyle(fontWeight: FontWeight.w600)),
          onDone: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
    );
  }
}
