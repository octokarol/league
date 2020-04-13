import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:league/ChampionsFromJson.dart';
import './ChampionDetails.dart';
import 'package:http/http.dart' as http;

var jsonSnapshot; //trzeba zmienic ta zmienna globalna np w jakas klase ze static - chcialem tylko zobaczyc czy dziala
enum WhichChampionDisplay { all, roster }
WhichChampionDisplay currentFilter = WhichChampionDisplay.all;

class Champions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChampionsState();
  }
}

class _ChampionsState extends State<Champions> {
  @override
  // ignore: must_call_super
  void initState() {
    setState(() {});
  }
/*
  Future<String> fetchRoster() async {
    final response = await http.get(
        'https://eun1.api.riotgames.com/lol/platform/v3/champion-rotations?api_key=RGAPI-5dcf5863-1239-4eb1-b276-3917e226e81e');
    Map<String, dynamic> rosterMap;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Future.delayed(Duration(seconds: 1), () => response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load roster');
    }
  }
*/
  @override
  Widget build(BuildContext context){
    if (jsonSnapshot.connectionState == ConnectionState.done) {
      var championsJsonString = jsonSnapshot.data.toString();
      final champions = championsFromJson(championsJsonString);
      double radioButtonsContainerHeight = 50;
      var championsListLength = champions.data.length;
      if (currentFilter == WhichChampionDisplay.roster) {

      }
      return new Stack(
        /*w stack najpierw musi byc lista potem radio buttons
                bo dziala to jak stos - jedno najpierw, nastepne przykrywa*/
        children: <Widget>[
          new Container(
              //kontenery w obu widgetach ustawiaja wysokosc elementu fixed
              margin: EdgeInsets.only(top: radioButtonsContainerHeight),
              child: new ListView.builder(
                  itemCount: championsListLength,
                  itemBuilder: (context, index) {
                    String key = champions.data.keys.elementAt(index);

                    return Padding(
                      padding: new EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 5.0),
                      child: new Card(
                        semanticContainer: true,
                        child: InkWell(
                          onTap: () {
                            /*
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("tego jeszcze nie mamy"),));
                            */
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChampionDetails(champions.data[key]),
                                ));
                          },
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Image.network(
                                'http://ddragon.leagueoflegends.com/cdn/img/champion/splash/' +
                                    champions.data[key].id +
                                    '_0.jpg',
                              ),
                              new Padding(
                                padding: new EdgeInsets.all(5.0),
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      champions.data[key].name,
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                    new SizedBox(
                                      height: 3.0,
                                    ),
                                    new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        new Text(
                                            "${champions.data[key].title}"),
                                        //new Text("linia: ${champions.data[index].lore}"),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
          new Positioned.fill(
              //pozycjonowanie radio buttons
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      height: radioButtonsContainerHeight,
                      child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Radio(
                              value: WhichChampionDisplay.all,
                              groupValue: currentFilter,
                              onChanged: (WhichChampionDisplay value) {
                                setState(() {
                                  currentFilter = value;
                                });
                              },
                            ),
                            new Text(
                              'Wszyscy',
                              style: new TextStyle(fontSize: 16.0),
                            ),
                            new Radio(
                              value: WhichChampionDisplay.roster,
                              groupValue: currentFilter,
                              onChanged: (WhichChampionDisplay value) {
                                setState(() {
                                  currentFilter = value;
                                });
                              },
                            ),
                            new Text(
                              "Rotacja",
                              style: new TextStyle(fontSize: 16.0),
                            )
                          ])))),
        ],
      );
    } else {
      return Scaffold(
          body: Center(
          child: Loading(
              indicator: BallSpinFadeLoaderIndicator(),
              size: 100.0,
              color: Colors.grey),
          //trzeba zakonczyc jakos animacje ladowania - w konsoli errory
        ),
      );
    }
  }
}
