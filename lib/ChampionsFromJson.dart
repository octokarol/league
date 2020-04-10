// To parse this JSON data, do
//
//     final champions = championsFromJson(jsonString);

import 'dart:convert';

Champions championsFromJson(String str) => Champions.fromJson(json.decode(str));

String championsToJson(Champions data) => json.encode(data.toJson());

class Champions {
  Type type;
  String format;
  Version version;
  Map<String, Datum> data;

  Champions({
    this.type,
    this.format,
    this.version,
    this.data,
  });

  factory Champions.fromJson(Map<String, dynamic> json) => Champions(
    type: typeValues.map[json["type"]],
    format: json["format"],
    version: versionValues.map[json["version"]],
    data: Map.from(json["data"]).map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "format": format,
    "version": versionValues.reverse[version],
    "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Datum {
  Version version;
  String id;
  String key;
  String name;
  String title;
  String blurb;
  Info info;
  ChampImage image;
  List<Tag> tags;
  String partype;
  Map<String, double> stats;

  Datum({
    this.version,
    this.id,
    this.key,
    this.name,
    this.title,
    this.blurb,
    this.info,
    this.image,
    this.tags,
    this.partype,
    this.stats,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    version: versionValues.map[json["version"]],
    id: json["id"],
    key: json["key"],
    name: json["name"],
    title: json["title"],
    blurb: json["blurb"],
    info: Info.fromJson(json["info"]),
    image: ChampImage.fromJson(json["image"]),
    tags: List<Tag>.from(json["tags"].map((x) => tagValues.map[x])),
    partype: json["partype"],
    stats: Map.from(json["stats"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "version": versionValues.reverse[version],
    "id": id,
    "key": key,
    "name": name,
    "title": title,
    "blurb": blurb,
    "info": info.toJson(),
    "image": image.toJson(),
    "tags": List<dynamic>.from(tags.map((x) => tagValues.reverse[x])),
    "partype": partype,
    "stats": Map.from(stats).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class ChampImage {
  String full;
  Sprite sprite;
  Type group;
  int x;
  int y;
  int w;
  int h;

  ChampImage({
    this.full,
    this.sprite,
    this.group,
    this.x,
    this.y,
    this.w,
    this.h,
  });

  factory ChampImage.fromJson(Map<String, dynamic> json) => ChampImage(
    full: json["full"],
    sprite: spriteValues.map[json["sprite"]],
    group: typeValues.map[json["group"]],
    x: json["x"],
    y: json["y"],
    w: json["w"],
    h: json["h"],
  );

  Map<String, dynamic> toJson() => {
    "full": full,
    "sprite": spriteValues.reverse[sprite],
    "group": typeValues.reverse[group],
    "x": x,
    "y": y,
    "w": w,
    "h": h,
  };
}

enum Type { CHAMPION }

final typeValues = EnumValues({
  "champion": Type.CHAMPION
});

enum Sprite { CHAMPION0_PNG, CHAMPION1_PNG, CHAMPION2_PNG, CHAMPION3_PNG, CHAMPION4_PNG }

final spriteValues = EnumValues({
  "champion0.png": Sprite.CHAMPION0_PNG,
  "champion1.png": Sprite.CHAMPION1_PNG,
  "champion2.png": Sprite.CHAMPION2_PNG,
  "champion3.png": Sprite.CHAMPION3_PNG,
  "champion4.png": Sprite.CHAMPION4_PNG
});

class Info {
  int attack;
  int defense;
  int magic;
  int difficulty;

  Info({
    this.attack,
    this.defense,
    this.magic,
    this.difficulty,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    attack: json["attack"],
    defense: json["defense"],
    magic: json["magic"],
    difficulty: json["difficulty"],
  );

  Map<String, dynamic> toJson() => {
    "attack": attack,
    "defense": defense,
    "magic": magic,
    "difficulty": difficulty,
  };
}

enum Tag { FIGHTER, TANK, MAGE, ASSASSIN, SUPPORT, MARKSMAN }

final tagValues = EnumValues({
  "Assassin": Tag.ASSASSIN,
  "Fighter": Tag.FIGHTER,
  "Mage": Tag.MAGE,
  "Marksman": Tag.MARKSMAN,
  "Support": Tag.SUPPORT,
  "Tank": Tag.TANK
});

enum Version { THE_1071 }

final versionValues = EnumValues({
  "10.7.1": Version.THE_1071
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
