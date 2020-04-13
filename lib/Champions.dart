import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:league/ChampionsFromJson.dart';
import './ChampionDetails.dart';

class JsonData {
  static var jsonSnapshot;
  static var allChampions;
  static var rosterChampions;
}

enum WhichChampionDisplay { all, roster }
WhichChampionDisplay currentFilter = WhichChampionDisplay.all;

class Champions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChampionsState();
  }
}

class _ChampionsState extends State<Champions> {
  var championsJsonString ;
  var champions;
  double radioButtonsContainerHeight; //w przyszlosci moze jakis kontruktor ktory "zapamietuje" preferencje
  var championsListLength;
  @override
  // ignore: must_call_super
  void initState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (JsonData.jsonSnapshot.connectionState == ConnectionState.done) {
      championsJsonString = JsonData.allChampions;
      champions = championsFromJson(championsJsonString);
      radioButtonsContainerHeight = 50;
      championsListLength = champions.data.length;
      if (currentFilter == WhichChampionDisplay.roster) { //obsluga rotacji
        var rosterMap = jsonDecode(JsonData.rosterChampions);
        championsListLength = rosterMap["freeChampionIds"].length;
        Map<String, Datum> tempChampMap = new Map<String, Datum>();
        champions.data.forEach((k,v) =>{
          //spradzam ktorzy czempioni z json ze wszystkimi sa w rotacji - porownuje pola key i usuwam te ktore nie jest w rotacji
          //musi byc zmienna tymczasowa, nie mozna edytowac podczas foreach
          if(rosterMap["freeChampionIds"].contains(int.parse(v.key)))
            {
              tempChampMap[k]=v
            }
        });
        champions.data=tempChampMap;
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
