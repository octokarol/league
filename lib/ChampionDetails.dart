import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChampionDetails extends StatelessWidget {

  //ChampionDetails(this.championName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("tytul"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("guwno"),
      ),
    );
  }

}