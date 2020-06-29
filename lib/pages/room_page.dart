import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:beinside/pages/groupdetailspage.dart';

class RoomPage extends StatelessWidget {
  const RoomPage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: 3,
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
                                    "group" + i.toString(), Icons.kitchen),
                              ));
                        },
                        leading: Icon(Icons.kitchen),
                        title: Text("Group1"))));
          }),
    );
  }
}
