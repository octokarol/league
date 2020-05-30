import 'package:flutter/material.dart';
import 'package:league/Json/Regions.dart';
import 'package:league/Screens/SummonerDetails.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Regions> _regions = Regions.getRegions();
  List<DropdownMenuItem<Regions>> _dropdownMenuItems;
  Regions _selectedRegion;

  List<DropdownMenuItem<Regions>> buildDropdownMenuItems(List regions) {
    List<DropdownMenuItem<Regions>> items = List();
    for (Regions region in regions) {
      items.add(DropdownMenuItem(
        value: region,
        child: Text(region.name),
      ));
    }
    return items;
  }

  handleSubmittion(String summonerName){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SummonerDetails(_selectedRegion, summonerName)));
  }

  updateSelectedRegion(Regions selectedRegion) {
    setState(() {
      _selectedRegion = selectedRegion;
    });
  }

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropdownMenuItems(_regions);
    _selectedRegion = _dropdownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () => _controller.clear(),
                    icon: Icon(Icons.clear),
                  ),
                  filled: true,
                  hintText: "imię przywoływacza"),
              textAlign: TextAlign.center,
              onSubmitted: handleSubmittion,
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.public),
                SizedBox(width: 10.0),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                      items: _dropdownMenuItems,
                      onChanged: updateSelectedRegion,
                      value: _selectedRegion,
                      ),
                )
              ],
            ),
          ],
        ));
  }
}
