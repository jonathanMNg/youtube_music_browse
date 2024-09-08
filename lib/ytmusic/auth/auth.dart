// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../helpers.dart';

const USER_AGENT =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:88.0) Gecko/20100101 Firefox/88.0';
const OAUTH_CLIENT_ID =
    "861556708454-d6dlm3lh05idd8npek18k6be8ba3oc68.apps.googleusercontent.com";
const OAUTH_CLIENT_SECRET = "SboVhoG9s0rNafixCSGGKXAT";
const OAUTH_SCOPE = "https://www.googleapis.com/auth/youtube";
const OAUTH_CODE_URL = "https://www.youtube.com/o/oauth2/device/code";
const OAUTH_TOKEN_URL = "https://oauth2.googleapis.com/token";
const OAUTH_USER_AGENT = "$USER_AGENT Cobalt/Version";

bool isOAuth() {
  // Map headers = Hive.box('SETTINGS').get('YTMUSIC_AUTH', defaultValue: {}); // TODO

  Map headers = {};
  var oauthStructure = {
    "access_token",
    "expires_at",
    "expires_in",
    "token_type",
    "refresh_token",
  };
  return oauthStructure.every((key) => headers.containsKey(key));
}

class AuthMixin {
  ValueNotifier<bool> isLogged = ValueNotifier(false);

  Future<http.Response> _sendRequest(
      String url, Map<String, String> data) async {
    data["client_id"] = OAUTH_CLIENT_ID;
    var headers = {"User-Agent": OAUTH_USER_AGENT};
    return await http.post(Uri.parse(url), body: data, headers: headers);
  }

  Future<Map<String, dynamic>> getCode() async {
    var codeResponse =
        await _sendRequest(OAUTH_CODE_URL, {"scope": OAUTH_SCOPE});
    var responseJson = jsonDecode(codeResponse.body);
    return responseJson;
  }

  Map<String, dynamic> _parseToken(Map<String, dynamic> token) {
    token["expires_at"] = token["expires_in"] != null
        ? (DateTime.now().millisecondsSinceEpoch / 1000).round() +
            int.parse(token["expires_in"].toString())
        : null;
    return token;
  }

  Future<Map<String, dynamic>> getTokenFromCode(String deviceCode) async {
    var response = await _sendRequest(
      OAUTH_TOKEN_URL,
      {
        "client_secret": OAUTH_CLIENT_SECRET,
        "grant_type": "http://oauth.net/grant_type/device/1.0",
        "code": deviceCode,
      },
    );
    return _parseToken(jsonDecode(response.body));
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    var response = await _sendRequest(
      OAUTH_TOKEN_URL,
      {
        "client_secret": OAUTH_CLIENT_SECRET,
        "grant_type": "refresh_token",
        "refresh_token": refreshToken,
      },
    );
    return _parseToken(jsonDecode(response.body));
  }


  // Future<bool> toggleLogin(BuildContext context) async {
  //   if (isLogged.value) {
  //     await Hive.box('SETTINGS').delete('YTMUSIC_AUTH');
  //     isLogged.value = false;
  //   } else {
  //     await login(context);
  //   }
  //   return isLogged.value;
  // }

  Future<Map<String, String>> loadHeaders() async {
    var headers = initializeHeaders();
    return headers;
  }
}
