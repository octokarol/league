import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChampionDetailOverview extends StatelessWidget {
  ChampionDetailOverview(this.championDetailsData);
  var championDetailsData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Hero(
            tag: championDetailsData.id,
            child: new Image.network(
              'http://ddragon.leagueoflegends.com/cdn/img/champion/splash/' +
                  championDetailsData.id +
                  '_0.jpg',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    championDetailsData.name + ", " + championDetailsData.title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  new SizedBox(height: 12.0),
                  new Text("Historia postaci",
                      style: Theme.of(context).textTheme.headline6),
                  new SizedBox(height: 3.0),
                  new Text(championDetailsData.blurb),
                  new SizedBox(height: 12.0),
                  new Text("Atrybuty",
                      style: Theme.of(context).textTheme.headline6),
                  new SizedBox(height: 3.0),
                  new Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new FaIcon(FontAwesomeIcons.skull),
                        new SizedBox(width: 9.0),
                        new Text("atak: " +
                            championDetailsData.info.attack.toString() +
                            "/10")
                      ]),
                  new SizedBox(height: 6.0),
                  new Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new FaIcon(FontAwesomeIcons.userShield),
                        new SizedBox(width: 9.0),
                        new Text("obrona: " +
                            championDetailsData.info.defense.toString() +
                            "/10")
                      ]),
                  new SizedBox(height: 6.0),
                  new Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new FaIcon(FontAwesomeIcons.diceD6),
                        new SizedBox(width: 9.0),
                        new Text("poziom trudności: " +
                            championDetailsData.info.difficulty.toString() +
                            "/10")
                      ]),
                  new SizedBox(height: 6.0),
                  new Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new FaIcon(FontAwesomeIcons.tint),
                        new SizedBox(width: 9.0),
                        new Text("magia: " +
                            championDetailsData.info.magic.toString() +
                            "/10")
                      ]),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
