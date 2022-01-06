// To parse this JSON data, do
//
//     final stand = standFromMap(jsonString);

import 'dart:convert';

import 'package:festival/models/Festival.model.dart';

import 'Passage.model.dart';

class Stand {
  Stand({
    this.id,
    this.attributes,
  });

  int? id;
  StandAttributes? attributes;

  factory Stand.fromJson(String str) => Stand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Stand.fromMap(Map<String, dynamic> json) => Stand(
        id: json["id"] == null ? null : json["id"],
        attributes: json["attributes"] == null
            ? null
            : StandAttributes.fromMap(json["attributes"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "attributes": attributes == null ? null : attributes!.toMap(),
      };
}

class StandAttributes {
  StandAttributes({
    this.name,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.passages,
    this.festival,
  });

  String? name;
  String? position;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? publishedAt;
  List<Passage>? passages;
  Festival? festival;

  factory StandAttributes.fromJson(String str) =>
      StandAttributes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StandAttributes.fromMap(Map<String, dynamic> json) => StandAttributes(
        name: json["Name"] == null ? null : json["Name"],
        position: json["position"] == null ? null : json["position"],
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
        festival:
            json["event"] == null ? null : Festival.fromMap(json["event"]),
      );

  Map<String, dynamic> toMap() => {
        "Name": name == null ? null : name,
        "position": position == null ? null : position,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "publishedAt":
            publishedAt == null ? null : publishedAt!.toIso8601String(),
        // "passages": passages == null ? null : passages!.toMap(),
        "event": festival == null ? null : festival!.toMap(),
      };
}
