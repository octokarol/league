import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:league/ChampionDetailsJsonData.dart';
import 'JsonData.dart';

class ChampionDetailStatistics extends StatelessWidget {
  var championDetailsData;
  var maxLevel = 18;
  ChampionDetailStatistics(this.championDetailsData);
  
  @override
  Widget build(BuildContext context) {
    // setTableRows();
    return DataTable(
      columns: [
        DataColumn(label: Text("Statystyka")),
        DataColumn(label: Text("Wartość"))
      ],
      rows: [
        DataRow(cells: [
          DataCell(Row(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.solidHeart),
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
              FaIcon(Icons.healing),
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
              FaIcon(FontAwesomeIcons.tint),
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
              FaIcon(FontAwesomeIcons.faucet),
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
              FaIcon(FontAwesomeIcons.expandAlt),
              Text("  Zasięg"),
            ],
          )),
          DataCell(Text(
              championDetailsData.stats["attackrange"].toStringAsFixed(2))),
        ]),
        DataRow(cells: [
          DataCell(Row(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.skull),
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
              FaIcon(FontAwesomeIcons.wind),
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
              FaIcon(FontAwesomeIcons.userShield),
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
              FaIcon(FontAwesomeIcons.umbrella),
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
              FaIcon(FontAwesomeIcons.running),
              Text("  Prędkość ruchu"),
            ],
          )),
          DataCell(Text(
              championDetailsData.stats["movespeed"].toStringAsFixed(2))),
        ]),
      ],
    );
  }
}
