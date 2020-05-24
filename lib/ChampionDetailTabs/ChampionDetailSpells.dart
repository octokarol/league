import 'package:flutter/material.dart';

class ChampionDetailSpells extends StatelessWidget {
  var championDetailsData;
  var spellsList;

  ChampionDetailSpells(this.championDetailsData, this.spellsList);

  @override
  Widget build(BuildContext context) {
    try {
      return buildDataTable(context);
    } catch (NoSuchMethodError) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }

  Padding buildDataTable(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            new Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: Column(children: <Widget>[
                  new ExpansionTile(
                    leading: Image.network(
                        'http://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/' +
                            spellsList[0].image.full),
                    title: Text("Q: " + spellsList[0].name),
                    subtitle: buildManaCost(0),
                    children: buildSpellPopup(0),
                  )
                ]),
              ),
            ),
            new Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: Column(children: <Widget>[
                  new ExpansionTile(
                    leading: Image.network(
                        'http://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/' +
                            spellsList[1].image.full),
                    title: Text("W: " + spellsList[1].name),
                    subtitle: buildManaCost(1),
                    children: buildSpellPopup(1),
                  )
                ]),
              ),
            ),
            new Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: Column(children: <Widget>[
                  new ExpansionTile(
                    leading: Image.network(
                        'http://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/' +
                            spellsList[2].image.full),
                    title: Text("E: " + spellsList[2].name),
                    subtitle: buildManaCost(2),
                    children: buildSpellPopup(2),
                  )
                ]),
              ),
            ),
            new Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: Column(children: <Widget>[
                  new ExpansionTile(
                    leading: Image.network(
                        'http://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/' +
                            spellsList[3].image.full),
                    title: Text("R: " + spellsList[3].name),
                    subtitle: buildManaCost(3),
                    children: buildSpellPopup(3),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text buildManaCost(var spellIndex) {
    if (spellsList[spellIndex].cost.last == 0) {
      return Text("koszt many: n/d" +"\n" "czas odnowienia: " + spellsList[spellIndex].cooldown.first.toString() +
                  " - " +
                  spellsList[spellIndex].cooldown.last.toString() + " [s]");
    } else return Text("koszt many: " +
                  spellsList[spellIndex].cost.first.toString() +
                  " - " +
                  spellsList[spellIndex].cost.last.toString()
                  + "\n" + "czas odnowienia: " + spellsList[spellIndex].cooldown.first.toString() +
                  " - " +
                  spellsList[spellIndex].cooldown.last.toString() + " [s]"
                  );
  }

  List<Widget> buildSpellPopup(var spellIndex) {
    return <Widget>[
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Table(children: [
                    TableRow(children: [
                      // FaIcon(FontAwesomeIcons.skull),
                      Text("Opis: " + spellsList[spellIndex].description),
                    ]),
                  ]),
                )
              ];
  }

}
