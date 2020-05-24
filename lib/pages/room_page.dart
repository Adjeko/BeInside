import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:beinside/pages/groupdetailspage.dart';

class RoomPage extends StatelessWidget {
  List<String> testGroups = {
    "Group1",
    "Group2",
    "Group3",
  }.toList();
  final List<IconData> testIcons = {
    Icons.kitchen,
    Icons.pool,
    Icons.beach_access,
  }.toList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: testGroups.length,
          itemBuilder: (context, i) {
            return Card(
                child: Material(
                    elevation: 5,
                    child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupDetailsPage(
                                    "group" + i.toString(), testIcons[i]),
                              ));
                        },
                        leading: Icon(testIcons[i]),
                        title: Text(testGroups[i]))));
          }),
    );
  }
}
