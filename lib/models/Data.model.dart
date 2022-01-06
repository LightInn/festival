// To parse this JSON data, do
//
//     final data = dataFromMap(jsonString);

import 'dart:convert';

import 'package:festival/models/Festival.model.dart';

/// Add factory functions for every Type and every constructor you want to make available to `make`
final factories = <Type, Function>{
  Festival: (map) => Festival.fromMap(map),
  // DataEntity: (json) => DataEntity().fromJson(json),
  // DataOneEntity: (json) => DataOneEntity().fromJson(json),
  // EventEntity: (json) => EventEntity().fromJson(json),
  // PassageEntity: (json) => PassageEntity().fromJson(json),
  // StandEntity: (json) => StandEntity().fromJson(json),
  // UserEntity: (json) => UserEntity().fromJson(json)
};

T make<T>(map) {
  return factories[T]!(map);
}

class Data<T> {
  Data({
    this.data,
    this.meta,
  });

  List<T>? data;
  Meta? meta;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? null
            : List<T>.from(json["data"].map((x) => make<T>(x))),
        meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x)),
        "meta": meta == null ? null : meta!.toMap(),
      };
}

class Meta {
  Meta({
    this.pagination,
  });

  Pagination? pagination;

  factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromMap(json["pagination"]),
      );

  Map<String, dynamic> toMap() => {
        "pagination": pagination == null ? null : pagination!.toMap(),
      };
}

class Pagination {
  Pagination({
    this.page,
    this.pageSize,
    this.pageCount,
    this.total,
  });

  int? page;
  int? pageSize;
  int? pageCount;
  int? total;

  factory Pagination.fromJson(String str) =>
      Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
        page: json["page"] == null ? null : json["page"],
        pageSize: json["pageSize"] == null ? null : json["pageSize"],
        pageCount: json["pageCount"] == null ? null : json["pageCount"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toMap() => {
        "page": page == null ? null : page,
        "pageSize": pageSize == null ? null : pageSize,
        "pageCount": pageCount == null ? null : pageCount,
        "total": total == null ? null : total,
      };
}
