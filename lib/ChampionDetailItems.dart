import 'package:flutter/material.dart';

class ChampionDetailItems extends StatelessWidget {
  var championDetailsData;

  ChampionDetailItems(this.championDetailsData);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.0),
      child: Text('przedmioty', style: TextStyle(fontSize: 36.0)),
    );
  }
}
