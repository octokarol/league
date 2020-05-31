class Regions {
  String name;
  String regionCode;

  Regions(this.name, this.regionCode);

  static List<Regions> getRegions() {
    return <Regions>[
      Regions("EUNE", "eun1"),
      Regions("EUW", "euw1"),
      Regions("LAN", "la1"),
      Regions("LAS", "la2"),
      Regions("OCE", "oc1"),
      Regions("NA", "na1"),
      Regions("KR", "kr"),
      Regions("JP", "jp1"),
      Regions("BR", "br1"),
      Regions("RU", "ru1"),
      Regions("TR", "tr1"),
    ];
  }
}
