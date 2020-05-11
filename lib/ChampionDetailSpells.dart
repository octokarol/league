import 'package:flutter/material.dart';

class ChampionDetailSpells extends StatelessWidget {
  var championDetailsData;
  var spellsList;

  ChampionDetailSpells(this.championDetailsData, this.spellsList);

  @override
  Widget build(BuildContext context) {
    try {
      return buildDataTable();
    } catch (NoSuchMethodError) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }

  DataTable buildDataTable() {
    return DataTable(columns: [
      DataColumn(label: Text("Ikona")),
      DataColumn(label: Text("Nazwa")),
      DataColumn(label: Text("Opis"))
    ], rows: [
      DataRow(cells: [
        DataCell(Image.network(
            'http://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/' +
                spellsList[0].image.full)),
        DataCell(Text(spellsList[0].name)),
        DataCell(Text(spellsList[0].description)),
      ]),
      DataRow(cells: [
        DataCell(Image.network(
            'http://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/' +
                spellsList[1].image.full)),
        DataCell(Text(spellsList[1].name)),
        DataCell(Text(spellsList[1].description)),
      ]),
      DataRow(cells: [
        DataCell(Image.network(
            'http://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/' +
                spellsList[2].image.full)),
        DataCell(Text(spellsList[2].name)),
        DataCell(Text(spellsList[2].description)),
      ]),
      DataRow(cells: [
        DataCell(Image.network(
            'http://ddragon.leagueoflegends.com/cdn/10.9.1/img/spell/' +
                spellsList[3].image.full)),
        DataCell(Text(spellsList[3].name)),
        DataCell(Text(spellsList[3].description)),
      ]),
    ]);
  }

//   Container buildDataTable() {
//     return Container(
//       chi
//     );
//  }
}