import 'package:flutter/material.dart';

import 'ChampionDetailItems.dart';
import 'ChampionDetailOverview.dart';
import 'ChampionDetailStatistics.dart';

// ignore: must_be_immutable
class ChampionDetails extends StatelessWidget {

  var championDetailsData;
  ChampionDetails(this.championDetailsData);


  @override
  Widget build(BuildContext context) {
    List<Widget> containers = [
      ChampionDetailOverview(championDetailsData),
      ChampionDetailStatistics(championDetailsData),
      ChampionDetailItems(championDetailsData)
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(championDetailsData.name),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'informacje',
                icon: Icon(Icons.person),
              ),
              Tab(
                text: 'statystyki',
                icon: Icon(Icons.list),
              ),
              Tab(
                text: 'przedmioty',
                icon: Icon(Icons.grain),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: containers,
        ),
      ),
    );
  }
}
