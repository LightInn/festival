import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtToken {
  final storage = const FlutterSecureStorage();

  getToken() async {
    String? jwt = await storage.read(key: "jwt");
    jwt = jwt ?? "Bearer ";
    // todo remetre null
    // jwt = jwt ?? "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjUxNzAyNDAxLCJleHAiOjE2NTQyOTQ0MDF9.aTyLsWCCwZ1qubfPNJD8W7D94iMhgN8zux8huzSmYK0";
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
