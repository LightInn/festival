// To parse this JSON data, do
//
//     final passage = passageFromMap(jsonString);

import 'dart:convert';

import 'package:festival/models/Artiste.model.dart';
import 'package:festival/models/Stand.model.dart';

class Passage {
  Passage({
    this.id,
    this.attributes,
  });

  int? id;
  PassageAttributes? attributes;

  factory Passage.fromJson(String str) => Passage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Passage.fromMap(Map<String, dynamic> json) => Passage(
    id: json["id"] == null ? null : json["id"],
    attributes: json["attributes"] == null ? null : PassageAttributes.fromMap(json["attributes"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "attributes": attributes == null ? null : attributes!.toMap(),
  };
}

class PassageAttributes {
  PassageAttributes({
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.start,
    this.end,
    this.artiste,
    this.stand,
  });

  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? publishedAt;
  DateTime? start;
  DateTime? end;
  Artiste? artiste;
  Stand? stand;

  factory PassageAttributes.fromJson(String str) => PassageAttributes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PassageAttributes.fromMap(Map<String, dynamic> json) => PassageAttributes(
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
    start: json["start"] == null ? null : DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
    artiste: json["artiste"] == null ? null : Artiste.fromMap(json["artiste"]["data"]),
    stand: json["stand"] == null ? null : Stand.fromMap(json["stand"]),
  );

  Map<String, dynamic> toMap() => {
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "publishedAt": publishedAt == null ? null : publishedAt!.toIso8601String(),
    "start": start == null ? null : start!.toIso8601String(),
    "end": end == null ? null : end!.toIso8601String(),
    "artiste": artiste == null ? null : artiste!.toMap(),
    "stand": stand == null ? null : stand!.toMap(),
  };
}
