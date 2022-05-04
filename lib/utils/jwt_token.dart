import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtToken {
  final storage = FlutterSecureStorage();

  getToken() async {
    String? jwt = await storage.read(key: "jwt");
    jwt = jwt ?? "Bearer null";
    log("getToken: $jwt");
    return jwt;
  }

  setToken(String token) async {
    await storage.write(key: "jwt", value: token);
    log("setToken: $token");
  }

  deleteToken() async {
    await storage.delete(key: "jwt");
    log("deleteToken");
  }

 Future<bool> haveToken() async {
    String? jwt = await storage.read(key: "jwt");
    final isToken = jwt == null ? false : true;
    log("haveToken: $isToken");
    return isToken;
  }
}
