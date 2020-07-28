import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text("Pig Dog Peter Enis"),
          Image.network(
              "https://vignette.wikia.nocookie.net/minions/images/7/75/Bob_Minion.jpg/revision/latest/top-crop/width/360/height/450?cb=20150812131120&path-prefix=de"),
          Text("Du hast echt viel Erfahrung"),
          Text("Und kein Geld du Opfa"),
        ],
      ),
    );
  }
}
