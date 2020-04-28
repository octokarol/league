import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import './Champions.dart';
import "./JsonData.dart";
import './MainPage.dart';
import './Settings.dart';
import 'DarkThemeProvider.dart';
import 'Styles.dart';

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
  Future<String> fetchRoster() async {
    final response = await http.get(
        'https://eun1.api.riotgames.com/lol/platform/v3/champion-rotations?api_key=RGAPI-5dcf5863-1239-4eb1-b276-3917e226e81e');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load roster');
    }
  }

  Future<String> fetchAllChampions() async {
    return await DefaultAssetBundle.of(context)
        .loadString('json/champions.json');
  }

  Future<Map<String, dynamic>> loadJsonSnapshots() async {
    Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    final responseRoster = await http.get(
        //czytam na razie tylko z neta - mialem problem z lokalnym plikien, wyjatek bez neta pozniej
        'https://eun1.api.riotgames.com/lol/platform/v3/champion-rotations?api_key=RGAPI-f3337aa5-af3f-4ade-89f9-245fd35d4eca'); //co jakis czas trzeba regenerowac link
    final responseAllChampions = await http.get(
        'http://ddragon.leagueoflegends.com/cdn/10.7.1/data/en_US/champion.json');
    if (responseAllChampions.statusCode == 200 &&
        responseRoster.statusCode == 200) {
      jsonMap["rosterChampions"] = responseRoster.body;
      jsonMap["allChampions"] = responseAllChampions.body;
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
      Champions(),
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
                  JsonData.allChampionsString = snapshot.data["allChampions"];
                  JsonData.rosterChampionsString =
                  snapshot.data["rosterChampions"];
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
