import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:league/ChampionsFromJson.dart';
import './ChampionDetails.dart';
import 'dart:io';
import 'dart:async';

var jsonSnapshot; //trzeba zmienic ta zmienna globalna np w jakas klase ze static - chcialem tylko zobaczyc czy dziala

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
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

          if (jsonSnapshot.connectionState==ConnectionState.done)
            {
              var championsJsonString = jsonSnapshot.data.toString();
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
                            /*
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("tego jeszcze nie mamy"),));
                            */
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => ChampionDetails(),
                            ));},
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Image.network(
                                'http://ddragon.leagueoflegends.com/cdn/img/champion/splash/'+champions.data[key].id+'_0.jpg',
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
        }
}
