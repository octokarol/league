import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("O aplikacji"),
        ),
        body: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("Michał Ręka i Karol Samujło"),
                subtitle: Text("programiści"),
                trailing: Icon(Icons.code),
              ),
              ListTile(
                title: Text("Daria Czajkowska i Wiktor Wesołowski"),
                subtitle: Text("graficy"),
                trailing: Icon(Icons.color_lens),
              ),
              ListTile(
                title: Text("Joanna Tarasiuk i Andrzej Ubych"),
                subtitle: Text("testerzy"),
                trailing: Icon(Icons.computer),
              )
            ],
          ),
        ));
  }
}
