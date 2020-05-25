import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:league/Screens/AboutScreen.dart';
import 'package:league/ProviderAndPreferences/DarkThemeProvider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Container(
        child: Column(
          children: <Widget>[
            
            ListTile(
              title: Text("O aplikacji"),
              trailing: Icon(Icons.arrow_forward),
              subtitle: Text("i jej autorach..."),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutScreen()));
              },
            ),
            SwitchListTile(
              value: themeChange.darkTheme,
              title: Text("tryb nocny 🌙"),
              onChanged: (value) {
                themeChange.darkTheme = value;
              },
            ),
          ],
        ));
  }
}
