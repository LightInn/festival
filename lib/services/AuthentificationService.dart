import 'dart:convert';
import 'dart:developer';

import 'package:festival/models/Auth.model.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

Future<Auth> register(email, password) async {
  var response = await http.post(
    Uri.parse(urlBase + "/api/auth/local/register"),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  var test = response.body;

  if (response.statusCode != 200) {
    log("ERROR : " + response.body);
  }

  Auth data = Auth.fromJson(response.body);

  return data;
}

Future<Auth> login(email, password) async {
  var response = await http.post(Uri.parse(urlBase + "/api/auth/local"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          'identifier': email,
          'password': password,
        },
      ));

  var test = response;
  var test1 = response.body;

  if (response.statusCode != 200) {
    log("ERROR : " + response.body);
  }

  var data = new Auth.fromJson(response.body);

  return data;
}
