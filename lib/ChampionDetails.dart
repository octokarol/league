import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:league/ChampionDetailsJsonData.dart';

import 'ChampionDetailSpells.dart';
import 'ChampionDetailOverview.dart';
import 'ChampionDetailStatistics.dart';
import 'ChampionsFromJson.dart';
import 'JsonData.dart';

// ignore: must_be_immutable
class ChampionDetails extends StatelessWidget {
  var championDetails;
  var championBasicData;
  ChampionDetails(Datum data) {
    this.championBasicData = data;
    championDetails = loadJsonSnapshots();
  }
  Future<Map<String, dynamic>> loadJsonSnapshots() async {
    Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    final responseDetails = await http.get(
        'http://ddragon.leagueoflegends.com/cdn/10.9.1/data/en_US/champion/' +
            championBasicData.id +
            '.json');
    jsonMap["championDetails"] = responseDetails.body;
    if (responseDetails.statusCode == 200) {
      return Future<Map<String, dynamic>>.delayed(
          Duration(seconds: 1), () => jsonMap);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load champion details');
    }
  }

var spellsList;
void updateSpellInformation(){
  if (JsonData.championDetailsClass != null) {
    spellsList = JsonData.championDetailsClass.data.champion.spells;
  }
  
}



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: championDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            JsonData.championDetailsClass = championDetailsJsonDataFromJson(
                snapshot.data["championDetails"], championBasicData.id);
                updateSpellInformation();    
          }
          List<Widget> containers = [
            ChampionDetailOverview(championBasicData),
            ChampionDetailStatistics(championBasicData),
            ChampionDetailSpells(championBasicData, spellsList)
          ];

          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text(championBasicData.name), //sprawdzam czy sie zaladowal dobrze json
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
                      text: 'umiejętności',
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
        });
  }
}
