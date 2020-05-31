import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:league/Json/Regions.dart';
import 'package:league/Json/JsonData.dart';

class SummonerDetails extends StatefulWidget {
  var selectedRegion;
  var summonerName;

  SummonerDetails(Regions selectedRegion, String summonerName) {
    this.selectedRegion = selectedRegion.regionCode;
    this.summonerName = summonerName;
  }

  @override
  _SummonerDetailsState createState() => _SummonerDetailsState();
}

class _SummonerDetailsState extends State<SummonerDetails> {

  Map<String, dynamic> summonerInfo = new Map<String, dynamic>();
  Map<String, dynamic> summonerMatchHistory = new Map<String, dynamic>();
  Map<String, dynamic> matchInfo = new Map<String, dynamic>();

   Future searchForSummoner() async {
    var summonerName = widget.summonerName.replaceAll(" ", "%20");
    var preparedURL = "https://" + widget.selectedRegion + ".api.riotgames.com/lol/summoner/v4/summoners/by-name/" + summonerName + "?api_key=" + JsonData.apiKey;
    var jsonResponse = await http.get(preparedURL);
    if (jsonResponse.statusCode != 200) {
      throw Exception('Failed to make connection with api');
    } else {
      summonerInfo = jsonDecode(utf8.decode(jsonResponse.bodyBytes));
      preparedURL = 'https://' + widget.selectedRegion + '.api.riotgames.com/lol/match/v4/matchlists/by-account/' + summonerInfo["accountId"] + '?api_key=' + JsonData.apiKey;
      jsonResponse = await http.get(preparedURL);
      if (jsonResponse.statusCode != 200) {
        throw Exception('Failed to make connection with api');
      } else {
        var champions = JsonData.allChampionsInfo;
        summonerMatchHistory = jsonDecode(utf8.decode(jsonResponse.bodyBytes));
      }
    }    
    Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    var match = summonerMatchHistory['matches'][0];
    var preparedURLMatch = "https://" + widget.selectedRegion + ".api.riotgames.com/lol/match/v4/matches/" + match['gameId'].toString() + "?api_key=" +JsonData.apiKey;
    var jsonResponseMatch = await http.get(preparedURLMatch);
    
    if (jsonResponseMatch.statusCode != 200) {
      throw Exception('Failed to make connection with api');
    } else {
      return jsonDecode(utf8.decode(jsonResponseMatch.bodyBytes));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.summonerName),
        ),
        body: Container(
          child: FutureBuilder(
            future: searchForSummoner(),
            builder: (context, snapshot){
                        if (snapshot.connectionState != ConnectionState.done || !snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                            return Text("loaded");
                        }
            }
            ) 
        ));
  }



}

