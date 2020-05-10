import 'package:flutter/material.dart';
import 'package:league/ChampionDetailsJsonData.dart';
import 'JsonData.dart';

class ChampionDetailStatistics extends StatelessWidget {
  var championDetailsData;
  var maxLevel = 18;
  var spellsList;
  var tableRows=<TableRow>[];
  ChampionDetailStatistics(this.championDetailsData);
  void setTableRows()
  {

    tableRows.add(new TableRow(
        children:
        [
          new Text("image"),
          new Text("name"),
          new Text("description")
        ]));
    if(JsonData.championDetailsClass!=null)
      {
        spellsList=JsonData.championDetailsClass.data.champion.spells;
        for(var i=0;i<spellsList.length;i++)
        {
          tableRows.add(new TableRow(
              children: [
                new Image.network(
                    'http://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/'+spellsList[i].image.full
                ),
                new Text(spellsList[i].name),
                new Text(spellsList[i].description),
              ]
          ));
        }
      }

  }
  @override
  Widget build(BuildContext context) {
    setTableRows();
    return ListView(
        children: <Widget>[
      new DataTable(
        columns: [
          DataColumn(label: Text("Statystyka")),
          DataColumn(label: Text("Wartość"))
        ],
        rows: [
          DataRow(cells: [
            DataCell(Row(
              children: <Widget>[
                //Image(image: AssetImage('Health_icon.png')),
                Text("  Zdrowie"),
              ],
            )),
            DataCell(Text(championDetailsData.stats["hp"].toStringAsFixed(2) +
                " - " +
                (championDetailsData.stats["hp"] +
                        (championDetailsData.stats["hpperlevel"] * maxLevel))
                    .toStringAsFixed(2))),
          ]),
          DataRow(cells: [
            DataCell(Row(
              children: <Widget>[
                Icon(Icons.face),
                Text("  Regen. zdrowia"),
              ],
            )),
            DataCell(Text(
                championDetailsData.stats["hpregen"].toStringAsFixed(2) +
                    " - " +
                    (championDetailsData.stats["hpregen"] +
                            (championDetailsData.stats["hpregenperlevel"] *
                                maxLevel))
                        .toStringAsFixed(2))),
          ]),
          DataRow(cells: [
            DataCell(Row(
              children: <Widget>[
                Icon(Icons.face),
                Text("  Mana"),
              ],
            )),
            DataCell(Text(championDetailsData.stats["mp"].toStringAsFixed(2) +
                " - " +
                (championDetailsData.stats["mp"] +
                        (championDetailsData.stats["mpperlevel"] * maxLevel))
                    .toStringAsFixed(2))),
          ]),
          DataRow(cells: [
            DataCell(Row(
              children: <Widget>[
                Icon(Icons.face),
                Text("  Regen. many"),
              ],
            )),
            DataCell(Text(
                championDetailsData.stats["mpregen"].toStringAsFixed(2) +
                    " - " +
                    (championDetailsData.stats["mpregen"] +
                            (championDetailsData.stats["mpregenperlevel"] *
                                maxLevel))
                        .toStringAsFixed(2))),
          ]),
          DataRow(cells: [
            DataCell(Row(
              children: <Widget>[
                Icon(Icons.face),
                Text("  Zasięg"),
              ],
            )),
            DataCell(Text(
                championDetailsData.stats["attackrange"].toStringAsFixed(2))),
          ]),
          DataRow(cells: [
            DataCell(Row(
              children: <Widget>[
                Icon(Icons.face),
                Text("  Obrażenia ataku"),
              ],
            )),
            DataCell(Text(
                championDetailsData.stats["attackdamage"].toStringAsFixed(2) +
                    " - " +
                    (championDetailsData.stats["attackdamage"] +
                            (championDetailsData.stats["attackdamageperlevel"] *
                                maxLevel))
                        .toStringAsFixed(2))),
          ]),
          DataRow(cells: [
            DataCell(Row(
              children: <Widget>[
                Icon(Icons.face),
                Text("  Prędkość ataku"),
              ],
            )),
            DataCell(Text(
                championDetailsData.stats["attackspeed"].toStringAsFixed(2) +
                    " - " +
                    (championDetailsData.stats["attackspeed"] +
                            (championDetailsData.stats["attackspeedperlevel"] *
                                maxLevel))
                        .toStringAsFixed(2))),
          ]),
          DataRow(cells: [
            DataCell(Row(
              children: <Widget>[
                Icon(Icons.face),
                Text("  Pancerz"),
              ],
            )),
            DataCell(Text(championDetailsData.stats["armor"]
                    .toStringAsFixed(2) +
                " - " +
                (championDetailsData.stats["armor"] +
                        (championDetailsData.stats["armorperlevel"] * maxLevel))
                    .toStringAsFixed(2))),
          ]),
          DataRow(cells: [
            DataCell(Row(
              children: <Widget>[
                Icon(Icons.face),
                Text("  Odp. na magię"),
              ],
            )),
            DataCell(Text(
                championDetailsData.stats["spellblock"].toStringAsFixed(2) +
                    " - " +
                    (championDetailsData.stats["spellblock"] +
                            (championDetailsData.stats["spellblockperlevel"] *
                                maxLevel))
                        .toStringAsFixed(2))),
          ]),
          DataRow(cells: [
            DataCell(Row(
              children: <Widget>[
                Icon(Icons.face),
                Text("  Prędkość ruchu"),
              ],
            )),
            DataCell(Text(
                championDetailsData.stats["movespeed"].toStringAsFixed(2))),
          ]),
        ],
      ),

          new Table(
        children: tableRows
      ),
    ]);
  }
}
