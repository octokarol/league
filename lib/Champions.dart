import 'package:flutter/material.dart';
import 'package:league/Champion.dart';

List<Champion> generateListOfChampions() {
  final champs = new List<Champion>();
  champs
    ..add(new Champion(
        "Ahri", "assasin", "mid", "graphics/champion_splashes/ahri.jpg"))
    ..add(new Champion(
        "Akali", "assasin", "mid", "graphics/champion_splashes/akali.jpg"));
//      ..add(new Champion())
  return champs;
}

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
  var _champs;

  @override
  // ignore: must_call_super
  void initState() {
    setState(() {
      _champs = generateListOfChampions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _champs.length,
        itemBuilder: (context, index){
          return Padding(
            padding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: new Card(
              semanticContainer: true,
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("tego jeszcze nie mamy"),));
                },
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Image.asset(_champs[index].imagePath,),
                    new Padding(
                      padding: new EdgeInsets.all(5.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            _champs[index].name,
                            style: Theme.of(context).textTheme.title,
                          ),
                          new SizedBox(
                            height: 3.0,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text("rola: ${_champs[index].role}"),
                              new Text("linia: ${_champs[index].lore}"),
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
}
