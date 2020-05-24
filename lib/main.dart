import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:league/Json/ChampionsFromJson.dart';
import 'package:league/Json/JsonData.dart';
import 'package:league/ProviderAndPreferences/DarkThemeProvider.dart';
import 'package:league/ProviderAndPreferences/Styles.dart';
import 'package:league/TabBarTabs/ChampionsList.dart';
import 'package:league/TabBarTabs/MainPage.dart';
import 'package:league/TabBarTabs/Settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final String title;
  MyApp({this.title});
  @override
  State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  void setPage(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            _title = titleIndex0;
            _selectedPage = index;
          }
          break;
        case 1:
          {
            _title = titleIndex1;
            _selectedPage = index;
          }
          break;
        case 2:
          {
            _title = titleIndex2;
            _selectedPage = index;
          }
          break;
      }
    });
  }

  int _selectedPage = 0;
  var _pageOptions = [];
  String _title;
  String titleIndex0 = "Strona główna";
  String titleIndex1 = "Postacie";
  String titleIndex2 = "Ustawienia";

  Future<Map<String, dynamic>> mapSnapshot;




  Future<String> fetchAllChampions() async {  //to w przyszlosci jesli bedziemy chcieli z lokalnego pliku json
    return await DefaultAssetBundle.of(context)
        .loadString('json/champions.json');
  }

  Future<Map<String, dynamic>> loadJsonSnapshots() async {
    Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    final responseRoster = await http.get(
        //czytam na razie tylko z neta - mialem problem z lokalnym plikien, wyjatek bez neta pozniej
        'https://eun1.api.riotgames.com/lol/platform/v3/champion-rotations?api_key='+JsonData.apiKey); //co jakis czas trzeba regenerowac link
    final responseAllChampions = await http.get(
        'http://ddragon.leagueoflegends.com/cdn/10.9.1/data/en_US/champion.json');
    if (responseAllChampions.statusCode == 200 &&
        responseRoster.statusCode == 200) {
      jsonMap["rosterChampions"] = responseRoster.body;
      jsonMap["allChampions"] = utf8.decode(responseAllChampions.bodyBytes);
      //jsonMap["items"] = responseItems.body;
      return Future<Map<String, dynamic>>.delayed(
          Duration(milliseconds: 100), () => jsonMap);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load roster');
    }
  }

  @override
  // ignore: must_call_super
  initState() {
    _title = titleIndex0;
    mapSnapshot = loadJsonSnapshots();
    getCurrentAppTheme();
  }

  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    _pageOptions = [
      MainPage(),
      ChampionsList(),
      Settings()
    ];
    //musi byc tutaj a nie w deklaracji bo inaczej sie wysypuje
    return ChangeNotifierProvider(create: (_) {
      return themeChangeProvider;
    }, child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return FutureBuilder(
              future: mapSnapshot,
              builder: (context, snapshot) {
                JsonData.jsonSnapshot = snapshot;
                if (snapshot.hasData) {
                  JsonData.allChampionsInfo = championsFromJson(snapshot.data["allChampions"]);
                  JsonData.rosterChampionsString =
                  snapshot.data["rosterChampions"];
                  //JsonData.itemsJsonString=snapshot.data["items"];
                }

                return MaterialApp(
                  //trzeba przeniesc logike ladowania jsona do main w async - po co ladowac pare razy to samo
                  // Decode the JSON
                  title: "FlutterDemo",
                  theme: Styles.themeData(
                      themeChangeProvider.darkTheme, context),
                  home: Scaffold(
                    appBar: AppBar(
                      title: Text(_title),
                    ),
                    body: _pageOptions[_selectedPage],
                    bottomNavigationBar: BottomNavigationBar(
                      currentIndex: _selectedPage,
                      onTap: (int index) {
                        setPage(index);
                      },
                      items: [
                        new BottomNavigationBarItem(
                            icon: Icon(Icons.home), title: Text(titleIndex0)),
                        new BottomNavigationBarItem(
                            icon: Icon(Icons.list), title: Text(titleIndex1)),
                        new BottomNavigationBarItem(
                            icon: Icon(Icons.settings), title: Text(
                            titleIndex2)),
                      ],
                    ),
                  ),
                );
              });
        }));
  }
}
