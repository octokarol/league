// To parse this JSON data, do
//
//     final championDetailsJsonData = championDetailsJsonDataFromJson(jsonString);

import 'dart:convert';

ChampionDetailsJsonData championDetailsJsonDataFromJson(String str,String name) => ChampionDetailsJsonData.fromJson(json.decode(str),name);

String championDetailsJsonDataToJson(ChampionDetailsJsonData data) => json.encode(data.toJson());

class ChampionDetailsJsonData {
  String type;
  String format;
  String version;
  Data data;
  String name;
  ChampionDetailsJsonData({
    this.type,
    this.format,
    this.version,
    this.data,
    this.name
  });

  factory ChampionDetailsJsonData.fromJson(Map<String, dynamic> json,String champName) => ChampionDetailsJsonData(
    type: json["type"],
    format: json["format"],
    version: json["version"],
    data: Data.fromJson(json["data"],champName),
    name: champName
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "format": format,
    "version": version,
    "data": data.toJson(),
  };
}

class Data {
  Champion champion;

  Data({
    this.champion,
  });

  factory Data.fromJson(Map<String, dynamic> json, String champName) => Data(
    champion: Champion.fromJson(json[champName]),
  );

  Map<String, dynamic> toJson() => {
    champion.id: champion.toJson(),
  };
}

class Champion {
  String id;
  String key;
  String name;
  String title;
  ChampionImage image;
  List<Skin> skins;
  String lore;
  String blurb;
  List<String> allytips;
  List<String> enemytips;
  List<String> tags;
  String partype;
  Info info;
  Map<String, double> stats;
  List<Spell> spells;
  Passive passive;
  List<Recommended> recommended;

  Champion({
    this.id,
    this.key,
    this.name,
    this.title,
    this.image,
    this.skins,
    this.lore,
    this.blurb,
    this.allytips,
    this.enemytips,
    this.tags,
    this.partype,
    this.info,
    this.stats,
    this.spells,
    this.passive,
    this.recommended,
  });

  factory Champion.fromJson(Map<String, dynamic> json) => Champion(
    id: json["id"],
    key: json["key"],
    name: json["name"],
    title: json["title"],
    image: ChampionImage.fromJson(json["image"]),
    skins: List<Skin>.from(json["skins"].map((x) => Skin.fromJson(x))),
    lore: json["lore"],
    blurb: json["blurb"],
    allytips: List<String>.from(json["allytips"].map((x) => x)),
    enemytips: List<String>.from(json["enemytips"].map((x) => x)),
    tags: List<String>.from(json["tags"].map((x) => x)),
    partype: json["partype"],
    info: Info.fromJson(json["info"]),
    stats: Map.from(json["stats"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
    spells: List<Spell>.from(json["spells"].map((x) => Spell.fromJson(x))),
    passive: Passive.fromJson(json["passive"]),
    recommended: List<Recommended>.from(json["recommended"].map((x) => Recommended.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "name": name,
    "title": title,
    "image": image.toJson(),
    "skins": List<dynamic>.from(skins.map((x) => x.toJson())),
    "lore": lore,
    "blurb": blurb,
    "allytips": List<dynamic>.from(allytips.map((x) => x)),
    "enemytips": List<dynamic>.from(enemytips.map((x) => x)),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "partype": partype,
    "info": info.toJson(),
    "stats": Map.from(stats).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "spells": List<dynamic>.from(spells.map((x) => x.toJson())),
    "passive": passive.toJson(),
    "recommended": List<dynamic>.from(recommended.map((x) => x.toJson())),
  };
}

class ChampionImage {
  String full;
  String sprite;
  String group;
  int x;
  int y;
  int w;
  int h;

  ChampionImage({
    this.full,
    this.sprite,
    this.group,
    this.x,
    this.y,
    this.w,
    this.h,
  });

  factory ChampionImage.fromJson(Map<String, dynamic> json) => ChampionImage(
    full: json["full"],
    sprite: json["sprite"],
    group: json["group"],
    x: json["x"],
    y: json["y"],
    w: json["w"],
    h: json["h"],
  );

  Map<String, dynamic> toJson() => {
    "full": full,
    "sprite": sprite,
    "group": group,
    "x": x,
    "y": y,
    "w": w,
    "h": h,
  };
}

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

class Passive {
  String name;
  String description;
  ChampionImage image;

  Passive({
    this.name,
    this.description,
    this.image,
  });

  factory Passive.fromJson(Map<String, dynamic> json) => Passive(
    name: json["name"],
    description: json["description"],
    image: ChampionImage.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "image": image.toJson(),
  };
}

class Recommended {
  String champion;
  String title;
  String map;
  String mode;
  String type;
  String customTag;
  int sortrank;
  bool extensionPage;
  bool useObviousCheckmark;
  dynamic customPanel;
  List<Block> blocks;

  Recommended({
    this.champion,
    this.title,
    this.map,
    this.mode,
    this.type,
    this.customTag,
    this.sortrank,
    this.extensionPage,
    this.useObviousCheckmark,
    this.customPanel,
    this.blocks,
  });

  factory Recommended.fromJson(Map<String, dynamic> json) => Recommended(
    champion: json["champion"],
    title: json["title"],
    map: json["map"],
    mode: json["mode"],
    type: json["type"],
    customTag: json["customTag"],
    sortrank: json["sortrank"] == null ? null : json["sortrank"],
    extensionPage: json["extensionPage"],
    useObviousCheckmark: json["useObviousCheckmark"] == null ? null : json["useObviousCheckmark"],
    customPanel: json["customPanel"],
    blocks: List<Block>.from(json["blocks"].map((x) => Block.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "champion": champion,
    "title": title,
    "map": map,
    "mode": mode,
    "type": type,
    "customTag": customTag,
    "sortrank": sortrank == null ? null : sortrank,
    "extensionPage": extensionPage,
    "useObviousCheckmark": useObviousCheckmark == null ? null : useObviousCheckmark,
    "customPanel": customPanel,
    "blocks": List<dynamic>.from(blocks.map((x) => x.toJson())),
  };
}

class Block {
  String type;
  bool recMath;
  bool recSteps;
  int minSummonerLevel;
  int maxSummonerLevel;
  IfSummonerSpell showIfSummonerSpell;
  IfSummonerSpell hideIfSummonerSpell;
  String appendAfterSection;
  List<String> visibleWithAllOf;
  List<String> hiddenWithAnyOf;
  List<Item> items;

  Block({
    this.type,
    this.recMath,
    this.recSteps,
    this.minSummonerLevel,
    this.maxSummonerLevel,
    this.showIfSummonerSpell,
    this.hideIfSummonerSpell,
    this.appendAfterSection,
    this.visibleWithAllOf,
    this.hiddenWithAnyOf,
    this.items,
  });

  factory Block.fromJson(Map<String, dynamic> json) => Block(
    type: json["type"],
    recMath: json["recMath"],
    recSteps: json["recSteps"],
    minSummonerLevel: json["minSummonerLevel"],
    maxSummonerLevel: json["maxSummonerLevel"],
    showIfSummonerSpell: ifSummonerSpellValues.map[json["showIfSummonerSpell"]],
    hideIfSummonerSpell: ifSummonerSpellValues.map[json["hideIfSummonerSpell"]],
    appendAfterSection: json["appendAfterSection"] == null ? null : json["appendAfterSection"],
    visibleWithAllOf: json["visibleWithAllOf"] == null ? null : List<String>.from(json["visibleWithAllOf"].map((x) => x)),
    hiddenWithAnyOf: json["hiddenWithAnyOf"] == null ? null : List<String>.from(json["hiddenWithAnyOf"].map((x) => x)),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "recMath": recMath,
    "recSteps": recSteps,
    "minSummonerLevel": minSummonerLevel,
    "maxSummonerLevel": maxSummonerLevel,
    "showIfSummonerSpell": ifSummonerSpellValues.reverse[showIfSummonerSpell],
    "hideIfSummonerSpell": ifSummonerSpellValues.reverse[hideIfSummonerSpell],
    "appendAfterSection": appendAfterSection == null ? null : appendAfterSection,
    "visibleWithAllOf": visibleWithAllOf == null ? null : List<dynamic>.from(visibleWithAllOf.map((x) => x)),
    "hiddenWithAnyOf": hiddenWithAnyOf == null ? null : List<dynamic>.from(hiddenWithAnyOf.map((x) => x)),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

enum IfSummonerSpell { EMPTY, SUMMONER_SMITE }

final ifSummonerSpellValues = EnumValues({
  "": IfSummonerSpell.EMPTY,
  "SummonerSmite": IfSummonerSpell.SUMMONER_SMITE
});

class Item {
  String id;
  int count;
  bool hideCount;

  Item({
    this.id,
    this.count,
    this.hideCount,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    count: json["count"],
    hideCount: json["hideCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "count": count,
    "hideCount": hideCount,
  };
}

class Skin {
  String id;
  int num;
  String name;
  bool chromas;

  Skin({
    this.id,
    this.num,
    this.name,
    this.chromas,
  });

  factory Skin.fromJson(Map<String, dynamic> json) => Skin(
    id: json["id"],
    num: json["num"],
    name: json["name"],
    chromas: json["chromas"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "num": num,
    "name": name,
    "chromas": chromas,
  };
}

class Spell {
  String id;
  String name;
  String description;
  String tooltip;
  Leveltip leveltip;
  int maxrank;
  List<dynamic> cooldown; //wszystkie list dynamic to albo list int albo list double
  String cooldownBurn;
  List<dynamic> cost;
  String costBurn;
  Datavalues datavalues;
  List<List<dynamic>> effect;
  List<String> effectBurn;
  List<dynamic> vars;
  String costType;
  String maxammo;
  List<dynamic> range;
  String rangeBurn;
  ChampionImage image;
  String resource;

  Spell({
    this.id,
    this.name,
    this.description,
    this.tooltip,
    this.leveltip,
    this.maxrank,
    this.cooldown,
    this.cooldownBurn,
    this.cost,
    this.costBurn,
    this.datavalues,
    this.effect,
    this.effectBurn,
    this.vars,
    this.costType,
    this.maxammo,
    this.range,
    this.rangeBurn,
    this.image,
    this.resource,
  });

  factory Spell.fromJson(Map<String, dynamic> json) => Spell(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    tooltip: json["tooltip"],
    leveltip: Leveltip.fromJson(json["leveltip"]),
    maxrank: json["maxrank"],
    cooldown: List<dynamic>.from(json["cooldown"].map((x) => x)),
    cooldownBurn: json["cooldownBurn"],
    cost: List<int>.from(json["cost"].map((x) => x)),
    costBurn: json["costBurn"],
    datavalues: Datavalues.fromJson(json["datavalues"]),
    effect: List<List<dynamic>>.from(json["effect"].map((x) => x == null ? null : List<dynamic>.from(x.map((x) => x)))),
    effectBurn: List<String>.from(json["effectBurn"].map((x) => x == null ? null : x)),
    vars: List<dynamic>.from(json["vars"].map((x) => x)),
    costType: json["costType"],
    maxammo: json["maxammo"],
    range: List<int>.from(json["range"].map((x) => x)),
    rangeBurn: json["rangeBurn"],
    image: ChampionImage.fromJson(json["image"]),
    resource: json["resource"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "tooltip": tooltip,
    "leveltip": leveltip.toJson(),
    "maxrank": maxrank,
    "cooldown": List<dynamic>.from(cooldown.map((x) => x)),
    "cooldownBurn": cooldownBurn,
    "cost": List<dynamic>.from(cost.map((x) => x)),
    "costBurn": costBurn,
    "datavalues": datavalues.toJson(),
    "effect": List<dynamic>.from(effect.map((x) => x == null ? null : List<dynamic>.from(x.map((x) => x)))),
    "effectBurn": List<dynamic>.from(effectBurn.map((x) => x == null ? null : x)),
    "vars": List<dynamic>.from(vars.map((x) => x)),
    "costType": costType,
    "maxammo": maxammo,
    "range": List<dynamic>.from(range.map((x) => x)),
    "rangeBurn": rangeBurn,
    "image": image.toJson(),
    "resource": resource,
  };
}

class Datavalues {
  Datavalues();

  factory Datavalues.fromJson(Map<String, dynamic> json) => Datavalues(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Leveltip {
  List<String> label;
  List<String> effect;

  Leveltip({
    this.label,
    this.effect,
  });

  factory Leveltip.fromJson(Map<String, dynamic> json) => Leveltip(
    label: List<String>.from(json["label"].map((x) => x)),
    effect: List<String>.from(json["effect"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "label": List<dynamic>.from(label.map((x) => x)),
    "effect": List<dynamic>.from(effect.map((x) => x)),
  };
}

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
