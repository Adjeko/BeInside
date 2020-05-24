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
      child: Container(
        child: ListView.builder(
          itemCount: testItems.length,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
              child: Dismissible(
                child: Container(
                  child: Card(
                    child: ListTile(title: Text(testItems[i])),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(1.0),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                background:
                    Container(color: Colors.green, child: Icon(Icons.check)),
                secondaryBackground:
                    Container(color: Colors.red, child: Icon(Icons.cancel)),
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
    );
  }
}
