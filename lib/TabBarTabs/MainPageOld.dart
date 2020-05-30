import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:league/Json/JsonData.dart';
import 'dart:convert';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final summonerNameController = TextEditingController();
  String selectedRegion = "EUNE";
  Map<String, String> regionsMap = new Map<String, String>();
  Map<String, dynamic> summonerInfo = new Map<String, dynamic>();
  Map<String, dynamic> summonerMatchHistory = new Map<String, dynamic>();
  Map<String, dynamic> matchInfo = new Map<String, dynamic>();
  List<Widget> summonerInfoRow = new List<Widget>();
  Widget matchHistoryList;
  // ignore: must_call_super
  void initState() {
    setState(() {
      regionsMap['EUNE'] = 'eun1';
      regionsMap['BR'] = 'br1';
      regionsMap['EUW'] = 'euw1';
      regionsMap['LAN'] = 'la1';
      regionsMap['LAS'] = 'la2';
      regionsMap['NA'] = 'na1';
      regionsMap['OCE'] = 'oc1';
      regionsMap['RU'] = 'ru1';
      regionsMap['TR'] = 'tr1';
      regionsMap['KR'] = 'kr';
      regionsMap['JP'] = 'jp1';
      matchHistoryList = Text("");
      summonerInfoRow.add(Text(""));
    });
  }

  Future<Map<String, dynamic>> searchForMatch(String gameID) async {
    Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    var preparedURL = "https://" +
        regionsMap[selectedRegion] +
        ".api.riotgames.com/lol/match/v4/matches/" +
        gameID +
        "?api_key=" +
        JsonData.apiKey;
    var jsonResponse = await http.get(preparedURL);
    if (jsonResponse.statusCode == 200) {
      jsonMap = jsonDecode(utf8.decode(jsonResponse.bodyBytes));
      return jsonMap;
    } else {
      throw Exception('Failed to make connection with api');
    }
  }

  void searchForSummoner() async {
    var summonerName = summonerNameController.text.replaceAll(" ", "%20");
    var preparedURL = "https://" +
        regionsMap[selectedRegion] +
        ".api.riotgames.com/lol/summoner/v4/summoners/by-name/" +
        summonerName +
        "?api_key=" +
        JsonData.apiKey;
    var jsonResponse = await http.get(preparedURL);
    if (jsonResponse.statusCode != 200) {
      throw Exception('Failed to make connection with api');
    } else {
      summonerInfo = jsonDecode(utf8.decode(jsonResponse.bodyBytes));
      preparedURL = 'https://' +
          regionsMap[selectedRegion] +
          '.api.riotgames.com/lol/match/v4/matchlists/by-account/' +
          summonerInfo["accountId"] +
          '?api_key=' +
          JsonData.apiKey;
      jsonResponse = await http.get(preparedURL);
      if (jsonResponse.statusCode != 200) {
        throw Exception('Failed to make connection with api');
      } else {
          matchHistoryList = new Expanded(
            child: new ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                //itemCount: summonerMatchHistory['matches'].length, //za duzo to sie dlugo laduje
                itemCount: 20,
                itemBuilder: (context, index) {
                  var match = summonerMatchHistory['matches'][index];
                  return new FutureBuilder(
                      future: searchForMatch(match['gameId'].toString()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done || !snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          matchInfo = snapshot.data;
                          int participantID = 0;
                          for (dynamic participant
                              in matchInfo['participantIdentities']) {
                            if (participant['player']['accountId'] == summonerInfo['accountId']) {
                              participantID = participant['participantId']-1;
                            }
                          }
                          dynamic stats =
                              matchInfo['participants'][participantID]['stats'];
                          String championKey = "";
                          for (String key in champions.data.keys) {
                            championKey = match['champion'].toString();
                            if (match['champion'].toString() ==
                                champions.data[key].key) {
                              championKey = key;
                              break;
                            }
                          }
                        }
                      });
                }),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Wybierz serwer"),
                DropdownButton<String>(
                    value: selectedRegion,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.white70,
                    ),
                    onChanged: (String changedValue) {
                      setState(() {
                        selectedRegion = changedValue;
                      });
                    },
                    items: <String>[
                      'BR',
                      'EUNE',
                      'EUW',
                      'LAN',
                      'LAS',
                      'NA',
                      'OCE',
                      'RU',
                      'TR',
                      'KR',
                      'JP'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
              ],
            ),
          ),
          TextField(
              controller: summonerNameController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Summoner Name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: searchForSummoner,
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: summonerInfoRow,
            ),
          ),
          matchHistoryList
        ],
      ),
    );
  }
}
