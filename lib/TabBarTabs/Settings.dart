import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:league/Screens/AboutScreen.dart';
import 'package:league/ProviderAndPreferences/DarkThemeProvider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            SwitchListTile(
              value: themeChange.darkTheme,
              title: Text("tryb nocny 🌙"),
              onChanged: (value) {
                themeChange.darkTheme = value;
              },
            ),
            ListTile(
              title: Text("O aplikacji"),
              subtitle: Text("i jej autorach..."),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutScreen()));
              },
            )
          ],
        ));
  }
}
