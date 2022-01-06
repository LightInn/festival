import 'dart:convert';
import 'dart:developer';

import 'package:festival/models/Auth.model.dart';
import 'package:festival/models/Data.model.dart';
import 'package:festival/models/Festival.model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

Future<List<Festival>> festivalGetAll() async {
  log("Get Festival All ()");

  FlutterSecureStorage storage = const FlutterSecureStorage();
  var jwt = await storage.read(key: "jwt");

  var response = await http.get(Uri.parse(urlBase + "/api/events"), headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt',
  });

  if (response.statusCode != 200) {
    log("ERROR : " + response.body);
  }

  Data<Festival> data = Data.fromJson(response.body);

  List<Festival> o = [];

  for (var festival in data.data ?? []) {
    o.add(festival);
  }

  return o;
}

Future<Festival> festivalGetOne(id) async {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  var jwt = storage.read(key: "jwt");

  var response =
  await http.get(Uri.parse(urlBase + "/api/events/" + id), headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt',
  });

  if (response.statusCode != 200) {
    log("ERROR : " + response.body);
  }

  Data<Festival> data = Data.fromJson(response.body);

  Festival festival = data.data![0];

  return festival;
}

// Future<Festival> create(Festival festival) async {
//   FlutterSecureStorage storage = const FlutterSecureStorage();
//   var jwt = storage.read(key: "jwt");
//
//   var response =
//   await http.get(Uri.parse(urlBase + "/api/events/" + id), headers: {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $jwt',
//   },
//   body: {
//
//
//     "{ data :   ATRIBUTE.TO JSON }"
//
//
//   });
//
//   if (response.statusCode != 200) {
//     log("ERROR : " + response.body);
//   }
//
//   Data<Festival> data = Data.fromJson(response.body);
//
//   Festival festival = data.data![0];
//
//   return festival;
// }




