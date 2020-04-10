import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:flutter/services.dart';
import 'package:league/ChampionsFromJson.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';



class Champions extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.0),
      child: Text('ustawienia', style: TextStyle(fontSize: 36.0)),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _ChampionsState();
  }
}

class _ChampionsState extends State<Champions> {
  var champsJsonClass;

  @override
  // ignore: must_call_super
  void initState() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(//trzeba przeniesc logike ladowania jsona do main w async - po co ladowac pare razy to samo
        future: DefaultAssetBundle  //DefaultAssetBundle mozna zmienic na swoja jakas funkcje
            .of(context)
            .loadString('json/champions.json'),
        builder: (context, snapshot) {
          // Decode the JSON
          var championsJsonString = snapshot.data.toString();
          if (snapshot.connectionState==ConnectionState.done)
            {
              final champions = championsFromJson(championsJsonString);
              return ListView.builder(
                  itemCount: champions.data.length,
                  itemBuilder: (context, index) {
                    String key = champions.data.keys.elementAt(index);
                    return Padding(
                      padding: new EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 5.0),
                      child: new Card(
                        semanticContainer: true,
                        child: InkWell(
                          onTap: () {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("tego jeszcze nie mamy"),));
                          },
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Image.network(
                                'http://ddragon.leagueoflegends.com/cdn/img/champion/splash/'+champions.data[key].id+'_0.jpg',
                                //trzeba dodac obsluge znakow specjalnych i spacji
                              ),
                              new Padding(
                                padding: new EdgeInsets.all(5.0),
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      champions.data[key].name,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .title,
                                    ),
                                    new SizedBox(
                                      height: 3.0,
                                    ),
                                    new Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        new Text("${champions.data[key].title}"),
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
                  });
            }
          else
            {
              return new Scaffold(
                  body: Container(
                    color: Colors.white,
                    child: Center(
                      child: Loading(indicator: BallSpinFadeLoaderIndicator(), size: 100.0,color: Colors.grey),
                      //trzeba zakonczyc jakos animacje ladowania - w konsoli errory
                    ),
                  )
              );
            }
        });
  }
}
