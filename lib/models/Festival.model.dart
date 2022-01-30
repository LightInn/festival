// To parse this JSON data, do
//
//     final festival = festivalFromMap(jsonString);

import 'dart:convert';

import 'package:festival/models/Stand.model.dart';

import 'Data.model.dart';

class Festival {
  Festival({
    this.id,
    this.attributes,
  });

  int? id;
  Attributes? attributes;

  factory Festival.fromJson(String str) => Festival.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Festival.fromMap(Map<String, dynamic> json) => Festival(
        id: json["id"] == null ? null : json["id"],
        attributes: json["attributes"] == null
            ? null
            : Attributes.fromMap(json["attributes"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "attributes": attributes == null ? null : attributes!.toMap(),
      };
}

class Attributes {
  Attributes(
      {this.name,
      this.startDate,
      this.endDate,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.stand});

  String? name;
  DateTime? startDate;
  DateTime? endDate;
  String? location;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? publishedAt;
  List<Stand>? stand;

  factory Attributes.fromJson(String str) =>
      Attributes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Attributes.fromMap(Map<String, dynamic> json) => Attributes(
      name: json["Name"] == null ? null : json["Name"],
      startDate:
          json["StartDate"] == null ? null : DateTime.parse(json["StartDate"]),
      endDate: json["EndDate"] == null ? null : DateTime.parse(json["EndDate"]),
      location: json["Location"] == null ? null : json["Location"],
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      publishedAt: json["publishedAt"] == null
          ? null
          : DateTime.parse(json["publishedAt"]),
      stand: json["stands"] == null
          ? null
          : List<Stand>.from(json["stands"]["data"].map((x) => Stand.fromMap(x))));

  Map<String, dynamic> toMap() => {
        "Name": name == null ? null : name,
        "StartDate": startDate == null
            ? null
            : "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "EndDate": endDate == null
            ? null
            : "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "Location": location == null ? null : location,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "publishedAt":
            publishedAt == null ? null : publishedAt!.toIso8601String(),
      };
}
