// To parse this JSON data, do
//
//     final itemsJsonData = itemsJsonDataFromJson(jsonString);

import 'dart:convert';

ItemsJsonData itemsJsonDataFromJson(String str) => ItemsJsonData.fromJson(json.decode(str));

String itemsJsonDataToJson(ItemsJsonData data) => json.encode(data.toJson());

class ItemsJsonData {
  Type type;
  String version;
  Basic basic;
  Map<String, Datum> data;
  List<Group> groups;
  List<Tree> tree;

  ItemsJsonData({
    this.type,
    this.version,
    this.basic,
    this.data,
    this.groups,
    this.tree,
  });

  factory ItemsJsonData.fromJson(Map<String, dynamic> json) => ItemsJsonData(
    type: typeValues.map[json["type"]],
    version: json["version"],
    basic: Basic.fromJson(json["basic"]),
    data: Map.from(json["data"]).map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
    groups: List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
    tree: List<Tree>.from(json["tree"].map((x) => Tree.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "version": version,
    "basic": basic.toJson(),
    "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "groups": List<dynamic>.from(groups.map((x) => x.toJson())),
    "tree": List<dynamic>.from(tree.map((x) => x.toJson())),
  };
}

class Basic {
  String name;
  Rune rune;
  Gold gold;
  String group;
  String description;
  String colloq;
  String plaintext;
  bool consumed;
  int stacks;
  int depth;
  bool consumeOnFull;
  List<dynamic> from;
  List<dynamic> into;
  int specialRecipe;
  bool inStore;
  bool hideFromAll;
  String requiredChampion;
  String requiredAlly;
  Map<String, int> stats;
  List<dynamic> tags;
  Map<String, bool> maps;

  Basic({
    this.name,
    this.rune,
    this.gold,
    this.group,
    this.description,
    this.colloq,
    this.plaintext,
    this.consumed,
    this.stacks,
    this.depth,
    this.consumeOnFull,
    this.from,
    this.into,
    this.specialRecipe,
    this.inStore,
    this.hideFromAll,
    this.requiredChampion,
    this.requiredAlly,
    this.stats,
    this.tags,
    this.maps,
  });

  factory Basic.fromJson(Map<String, dynamic> json) => Basic(
    name: json["name"],
    rune: Rune.fromJson(json["rune"]),
    gold: Gold.fromJson(json["gold"]),
    group: json["group"],
    description: json["description"],
    colloq: json["colloq"],
    plaintext: json["plaintext"],
    consumed: json["consumed"],
    stacks: json["stacks"],
    depth: json["depth"],
    consumeOnFull: json["consumeOnFull"],
    from: List<dynamic>.from(json["from"].map((x) => x)),
    into: List<dynamic>.from(json["into"].map((x) => x)),
    specialRecipe: json["specialRecipe"],
    inStore: json["inStore"],
    hideFromAll: json["hideFromAll"],
    requiredChampion: json["requiredChampion"],
    requiredAlly: json["requiredAlly"],
    stats: Map.from(json["stats"]).map((k, v) => MapEntry<String, int>(k, v)),
    tags: List<dynamic>.from(json["tags"].map((x) => x)),
    maps: Map.from(json["maps"]).map((k, v) => MapEntry<String, bool>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "rune": rune.toJson(),
    "gold": gold.toJson(),
    "group": group,
    "description": description,
    "colloq": colloq,
    "plaintext": plaintext,
    "consumed": consumed,
    "stacks": stacks,
    "depth": depth,
    "consumeOnFull": consumeOnFull,
    "from": List<dynamic>.from(from.map((x) => x)),
    "into": List<dynamic>.from(into.map((x) => x)),
    "specialRecipe": specialRecipe,
    "inStore": inStore,
    "hideFromAll": hideFromAll,
    "requiredChampion": requiredChampion,
    "requiredAlly": requiredAlly,
    "stats": Map.from(stats).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "maps": Map.from(maps).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class Gold {
  int base;
  int total;
  int sell;
  bool purchasable;

  Gold({
    this.base,
    this.total,
    this.sell,
    this.purchasable,
  });

  factory Gold.fromJson(Map<String, dynamic> json) => Gold(
    base: json["base"],
    total: json["total"],
    sell: json["sell"],
    purchasable: json["purchasable"],
  );

  Map<String, dynamic> toJson() => {
    "base": base,
    "total": total,
    "sell": sell,
    "purchasable": purchasable,
  };
}

class Rune {
  bool isrune;
  int tier;
  String type;

  Rune({
    this.isrune,
    this.tier,
    this.type,
  });

  factory Rune.fromJson(Map<String, dynamic> json) => Rune(
    isrune: json["isrune"],
    tier: json["tier"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "isrune": isrune,
    "tier": tier,
    "type": type,
  };
}

class Datum {
  String name;
  String description;
  String colloq;
  String plaintext;
  List<String> into;
  Image image;
  Gold gold;
  List<String> tags;
  Map<String, bool> maps;
  Map<String, double> stats;
  bool inStore;
  List<String> from;
  Effect effect;
  int depth;
  int stacks;
  bool consumed;
  bool hideFromAll;
  bool consumeOnFull;
  int specialRecipe;
  String requiredChampion;
  RequiredAlly requiredAlly;

  Datum({
    this.name,
    this.description,
    this.colloq,
    this.plaintext,
    this.into,
    this.image,
    this.gold,
    this.tags,
    this.maps,
    this.stats,
    this.inStore,
    this.from,
    this.effect,
    this.depth,
    this.stacks,
    this.consumed,
    this.hideFromAll,
    this.consumeOnFull,
    this.specialRecipe,
    this.requiredChampion,
    this.requiredAlly,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    description: json["description"],
    colloq: json["colloq"],
    plaintext: json["plaintext"],
    into: json["into"] == null ? null : List<String>.from(json["into"].map((x) => x)),
    image: Image.fromJson(json["image"]),
    gold: Gold.fromJson(json["gold"]),
    tags: List<String>.from(json["tags"].map((x) => x)),
    maps: Map.from(json["maps"]).map((k, v) => MapEntry<String, bool>(k, v)),
    stats: Map.from(json["stats"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
    inStore: json["inStore"] == null ? null : json["inStore"],
    from: json["from"] == null ? null : List<String>.from(json["from"].map((x) => x)),
    effect: json["effect"] == null ? null : Effect.fromJson(json["effect"]),
    depth: json["depth"] == null ? null : json["depth"],
    stacks: json["stacks"] == null ? null : json["stacks"],
    consumed: json["consumed"] == null ? null : json["consumed"],
    hideFromAll: json["hideFromAll"] == null ? null : json["hideFromAll"],
    consumeOnFull: json["consumeOnFull"] == null ? null : json["consumeOnFull"],
    specialRecipe: json["specialRecipe"] == null ? null : json["specialRecipe"],
    requiredChampion: json["requiredChampion"] == null ? null : json["requiredChampion"],
    requiredAlly: json["requiredAlly"] == null ? null : requiredAllyValues.map[json["requiredAlly"]],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "colloq": colloq,
    "plaintext": plaintext,
    "into": into == null ? null : List<dynamic>.from(into.map((x) => x)),
    "image": image.toJson(),
    "gold": gold.toJson(),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "maps": Map.from(maps).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "stats": Map.from(stats).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "inStore": inStore == null ? null : inStore,
    "from": from == null ? null : List<dynamic>.from(from.map((x) => x)),
    "effect": effect == null ? null : effect.toJson(),
    "depth": depth == null ? null : depth,
    "stacks": stacks == null ? null : stacks,
    "consumed": consumed == null ? null : consumed,
    "hideFromAll": hideFromAll == null ? null : hideFromAll,
    "consumeOnFull": consumeOnFull == null ? null : consumeOnFull,
    "specialRecipe": specialRecipe == null ? null : specialRecipe,
    "requiredChampion": requiredChampion == null ? null : requiredChampion,
    "requiredAlly": requiredAlly == null ? null : requiredAllyValues.reverse[requiredAlly],
  };
}

class Effect {
  String effect1Amount;
  String effect2Amount;
  String effect3Amount;
  String effect4Amount;
  String effect5Amount;
  String effect6Amount;
  String effect7Amount;
  String effect8Amount;
  String effect9Amount;
  String effect10Amount;
  String effect11Amount;
  String effect12Amount;
  String effect13Amount;
  String effect14Amount;
  String effect15Amount;
  String effect16Amount;
  String effect17Amount;
  String effect18Amount;

  Effect({
    this.effect1Amount,
    this.effect2Amount,
    this.effect3Amount,
    this.effect4Amount,
    this.effect5Amount,
    this.effect6Amount,
    this.effect7Amount,
    this.effect8Amount,
    this.effect9Amount,
    this.effect10Amount,
    this.effect11Amount,
    this.effect12Amount,
    this.effect13Amount,
    this.effect14Amount,
    this.effect15Amount,
    this.effect16Amount,
    this.effect17Amount,
    this.effect18Amount,
  });

  factory Effect.fromJson(Map<String, dynamic> json) => Effect(
    effect1Amount: json["Effect1Amount"],
    effect2Amount: json["Effect2Amount"] == null ? null : json["Effect2Amount"],
    effect3Amount: json["Effect3Amount"] == null ? null : json["Effect3Amount"],
    effect4Amount: json["Effect4Amount"] == null ? null : json["Effect4Amount"],
    effect5Amount: json["Effect5Amount"] == null ? null : json["Effect5Amount"],
    effect6Amount: json["Effect6Amount"] == null ? null : json["Effect6Amount"],
    effect7Amount: json["Effect7Amount"] == null ? null : json["Effect7Amount"],
    effect8Amount: json["Effect8Amount"] == null ? null : json["Effect8Amount"],
    effect9Amount: json["Effect9Amount"] == null ? null : json["Effect9Amount"],
    effect10Amount: json["Effect10Amount"] == null ? null : json["Effect10Amount"],
    effect11Amount: json["Effect11Amount"] == null ? null : json["Effect11Amount"],
    effect12Amount: json["Effect12Amount"] == null ? null : json["Effect12Amount"],
    effect13Amount: json["Effect13Amount"] == null ? null : json["Effect13Amount"],
    effect14Amount: json["Effect14Amount"] == null ? null : json["Effect14Amount"],
    effect15Amount: json["Effect15Amount"] == null ? null : json["Effect15Amount"],
    effect16Amount: json["Effect16Amount"] == null ? null : json["Effect16Amount"],
    effect17Amount: json["Effect17Amount"] == null ? null : json["Effect17Amount"],
    effect18Amount: json["Effect18Amount"] == null ? null : json["Effect18Amount"],
  );

  Map<String, dynamic> toJson() => {
    "Effect1Amount": effect1Amount,
    "Effect2Amount": effect2Amount == null ? null : effect2Amount,
    "Effect3Amount": effect3Amount == null ? null : effect3Amount,
    "Effect4Amount": effect4Amount == null ? null : effect4Amount,
    "Effect5Amount": effect5Amount == null ? null : effect5Amount,
    "Effect6Amount": effect6Amount == null ? null : effect6Amount,
    "Effect7Amount": effect7Amount == null ? null : effect7Amount,
    "Effect8Amount": effect8Amount == null ? null : effect8Amount,
    "Effect9Amount": effect9Amount == null ? null : effect9Amount,
    "Effect10Amount": effect10Amount == null ? null : effect10Amount,
    "Effect11Amount": effect11Amount == null ? null : effect11Amount,
    "Effect12Amount": effect12Amount == null ? null : effect12Amount,
    "Effect13Amount": effect13Amount == null ? null : effect13Amount,
    "Effect14Amount": effect14Amount == null ? null : effect14Amount,
    "Effect15Amount": effect15Amount == null ? null : effect15Amount,
    "Effect16Amount": effect16Amount == null ? null : effect16Amount,
    "Effect17Amount": effect17Amount == null ? null : effect17Amount,
    "Effect18Amount": effect18Amount == null ? null : effect18Amount,
  };
}

class Image {
  String full;
  Sprite sprite;
  Type group;
  int x;
  int y;
  int w;
  int h;

  Image({
    this.full,
    this.sprite,
    this.group,
    this.x,
    this.y,
    this.w,
    this.h,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
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

enum Type { ITEM }

final typeValues = EnumValues({
  "item": Type.ITEM
});

enum Sprite { ITEM0_PNG, ITEM1_PNG, ITEM2_PNG }

final spriteValues = EnumValues({
  "item0.png": Sprite.ITEM0_PNG,
  "item1.png": Sprite.ITEM1_PNG,
  "item2.png": Sprite.ITEM2_PNG
});

enum RequiredAlly { ORNN }

final requiredAllyValues = EnumValues({
  "Ornn": RequiredAlly.ORNN
});

class Group {
  String id;
  String maxGroupOwnable;

  Group({
    this.id,
    this.maxGroupOwnable,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    id: json["id"],
    maxGroupOwnable: json["MaxGroupOwnable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "MaxGroupOwnable": maxGroupOwnable,
  };
}

class Tree {
  String header;
  List<String> tags;

  Tree({
    this.header,
    this.tags,
  });

  factory Tree.fromJson(Map<String, dynamic> json) => Tree(
    header: json["header"],
    tags: List<String>.from(json["tags"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "header": header,
    "tags": List<dynamic>.from(tags.map((x) => x)),
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
