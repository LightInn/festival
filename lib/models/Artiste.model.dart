// To parse this JSON data, do
//
//     final artiste = artisteFromMap(jsonString);

import 'dart:convert';

import 'package:festival/models/Passage.model.dart';

class Artiste {
  Artiste({
    this.id,
    this.attributes,
  });

  int? id;
  ArtisteAttributes? attributes;

  factory Artiste.fromJson(String str) => Artiste.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Artiste.fromMap(Map<String, dynamic> json) => Artiste(
        id: json["id"] == null ? null : json["id"],
        attributes: json["attributes"] == null
            ? null
            : ArtisteAttributes.fromMap(json["attributes"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "attributes": attributes == null ? null : attributes!.toMap(),
      };
}

class ArtisteAttributes {
  ArtisteAttributes({
    this.name,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.passages,
    this.profile,
  });

  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? publishedAt;
  List<Passage>? passages;
  String? profile;

  factory ArtisteAttributes.fromJson(String str) =>
      ArtisteAttributes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArtisteAttributes.fromMap(Map<String, dynamic> json) =>
      ArtisteAttributes(
        name: json["Name"] == null ? null : json["Name"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        publishedAt: json["publishedAt"] == null
            ? null
            : DateTime.parse(json["publishedAt"]),
        passages: json["passages"] == null
            ? null
            : List<Passage>.from(
                json["passages"].map((x) => Passage.fromMap(x))),
        profile: json["profile"] == null ? null : json["profile"],
      );

  Map<String, dynamic> toMap() => {
        "Name": name == null ? null : name,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "publishedAt":
            publishedAt == null ? null : publishedAt!.toIso8601String(),
        // "passages": passages == null ? null : passages!.toMap(),
        "profile": profile == null ? null : profile,
      };
}
