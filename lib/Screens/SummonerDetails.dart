import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:league/Json/Regions.dart';
import 'package:league/Json/JsonData.dart';

class SummonerDetails extends StatefulWidget {
  SummonerDetails(Regions selectedRegion, String summonerName) {
    this.selectedRegion = selectedRegion.regionCode;
    this.summonerName = summonerName;
  }

  var selectedRegion;
  var summonerName;

  @override
  _SummonerDetailsState createState() => _SummonerDetailsState();
}

class _SummonerDetailsState extends State<SummonerDetails> {
  static final int numOfMatches = 5;

  List<dynamic> decodedMatches = List<dynamic>();
  Map<String, dynamic> matchInfo = new Map<String, dynamic>();
  Map<String, dynamic> summonerInfo = new Map<String, dynamic>();
  Map<String, dynamic> summonerMatchHistory = new Map<String, dynamic>();

  Future searchForSummoner() async {
    var summonerName = widget.summonerName.replaceAll(" ", "%20");
    var preparedURL = "https://" +
        widget.selectedRegion +
        ".api.riotgames.com/lol/summoner/v4/summoners/by-name/" +
        summonerName +
        "?api_key=" +
        JsonData.apiKey;
    var jsonResponse = await http.get(preparedURL);
    //sprawdzam tylko raz; jak nie ma neta to nie ma wiekszego sensu sprawdzac potem
    //no chyba ze ktos odetnie sobie internet w trakcie szukania
    //wtedy przykra sprawa :(
    if (jsonResponse.statusCode != 200) {
      return false;
    } else {
      summonerInfo = jsonDecode(utf8.decode(jsonResponse.bodyBytes));
      preparedURL = 'https://' +
          widget.selectedRegion +
          '.api.riotgames.com/lol/match/v4/matchlists/by-account/' +
          summonerInfo["accountId"] +
          '?api_key=' +
          JsonData.apiKey;
      jsonResponse = await http.get(preparedURL);
      var champions = JsonData.allChampionsInfo;
      summonerMatchHistory = jsonDecode(utf8.decode(jsonResponse.bodyBytes));
      return summonerMatchHistory;
    }
    // Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    // for (var i = 0; i < numOfMatches; i++) {
    //   var jsonResponseMatch = await http.get(getMatchURL(i));
    //   decodedMatches.add(jsonDecode(utf8.decode(jsonResponseMatch.bodyBytes)));
    // }
    // return decodedMatches;
  }

  String getMatchURL(int i) {
    var match = summonerMatchHistory['matches'][i];
    var preparedURLMatch = "https://" +
        widget.selectedRegion +
        ".api.riotgames.com/lol/match/v4/matches/" +
        match['gameId'].toString() +
        "?api_key=" +
        JsonData.apiKey;
    return preparedURLMatch;
  }

  ListTile buildSummonerHeader() {
    return ListTile(
      title: Text(summonerInfo['name']),
      subtitle: Text(
          "poziom przywoływacza: " + summonerInfo['summonerLevel'].toString()),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          'http://ddragon.leagueoflegends.com/cdn/10.9.1/img/profileicon/' +
              summonerInfo['profileIconId'].toString() +
              '.png',
        ),
        radius: 25.0,
      ),
    );
  }

  Padding buildErrorScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            size: 40.0,
          ),
          SizedBox(height: 10.0),
          Text("brak takiego przywoływacza lub problem z polączeniem",
              style: Theme.of(context).textTheme.headline6),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Szukaj"),
        ),
        body: Container(
            child: FutureBuilder(
                future: searchForSummoner(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done ||
                      !snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (summonerInfo.isEmpty) {
                      return buildErrorScreen(context);
                    } else
                      return Container(
                          child: Column(
                        children: <Widget>[
                          buildSummonerHeader(),
                          SizedBox(height: 10.0),
                          Text("historia rozegranych meczy:",
                              style: Theme.of(context).textTheme.headline5),
                          SizedBox(height: 10.0),
                          ListView.builder(
                            itemCount: numOfMatches,
                            itemBuilder: null,
                          )
                        ],
                      ));
                  }
                })));
  }
}
