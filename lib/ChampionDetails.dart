import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChampionDetails extends StatelessWidget {

  var championDetailsData;

  ChampionDetails(this.championDetailsData);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(championDetailsData.name),
      ),
      body: ListView.builder(
        itemCount: championDetailsData.stats.length,
        itemBuilder: (context, index) {
          String key = championDetailsData.stats.keys.elementAt(index);
          return Text(
              key+": "+championDetailsData.stats[key].toString()
          );
        }),
    );
  }
}