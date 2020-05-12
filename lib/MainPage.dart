import 'dart:io';
import 'package:league/JsonData.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final summonerNameController = TextEditingController();
  String stateTest="";
  String selectedRegion="EUNE";
  Map<String,String> regionsMap= new Map<String,String>();
  Map<String, dynamic> summonerInfo = new Map<String,dynamic>();
  // ignore: must_call_super
  void initState() {
    setState(() {
      regionsMap['EUNE']='eun1';
      regionsMap['BR']='br1';
      regionsMap['EUW']='euw1';
      regionsMap['LAN']='la1';
      regionsMap['LAS']='la2';
      regionsMap['NA']='na1';
      regionsMap['OCE']='oc1';
      regionsMap['RU']='ru1';
      regionsMap['TR']='tr1';
      regionsMap['KR']='kr';
      regionsMap['JP']='jp1';

      summonerInfo["summonerLevel"]="";
    });
  }
  void searchForSummoner() async{
    var summonerName = summonerNameController.text.replaceAll(" ", "%20");
    var preparedURL = "https://eun1.api.riotgames.com/lol/summoner/v4/summoners/by-name/" +
        summonerName + "?api_key=" + JsonData.apiKey;
    final jsonResponse = await http.get(preparedURL);
    setState((){
      if (jsonResponse.statusCode == 200) {
        summonerInfo = jsonDecode(utf8.decode(jsonResponse.bodyBytes));
      }
      else {
        throw Exception('Failed to make connection with data');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
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
                  }).toList()
                ),
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
          Row(
            children: <Widget>[
              Text(summonerInfo["summonerLevel"].toString())
            ],
          )
        ],
      ),
    );
  }
}
