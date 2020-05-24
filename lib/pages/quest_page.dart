import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestPage extends StatelessWidget {
  final List<String> testItems = {
    "Item1",
    "Item2",
    "Item3",
  }.toList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.network(
              "https://blog.strava.com/wp-content/uploads/2017/03/FitFreshillustration.png"),
          Container(
            child: Expanded(
              child: ListView.builder(
                itemCount: testItems.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Dismissible(
                      child: Container(
                        child: Card(
                          child: Material(
                            elevation: 5,
                            child: ListTile(title: Text(testItems[i]))),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      background: Container(
                          color: Colors.green, child: Icon(Icons.check)),
                      secondaryBackground: Container(
                          color: Colors.red, child: Icon(Icons.cancel)),
                      onDismissed: (direction) {
                        switch (direction) {
                          case DismissDirection.startToEnd:
                            break;
                          case DismissDirection.endToStart:
                            break;
                          default:
                        }
                      },
                      key: ValueKey("Test"),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
