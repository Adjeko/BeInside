import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:beinside/models/group.dart';

class GroupSearchPage extends StatelessWidget {
  GroupSearchPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.arrow_back),
        actions: <Widget>[Icon(Icons.more_vert)],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<List<Group>>(
              stream: Group.streamGroupSearchFromFirestore(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                List<Group> groups = snapshot.data;

                return Expanded(
                  child: ListView.builder(
                    itemCount: groups.length,
                    itemBuilder: (context, i) {
                      return groups[i].buildListTile(context);
                    },
                  ),
                );
              },
            ),
            RaisedButton(
                child: Text("Laden"),
                onPressed: () {
                  Group.streamGroupSearchFromFirestore();
                }),
          ],
        ),
      ),
    );
  }
}
