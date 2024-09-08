import 'dart:convert';
import 'package:http/http.dart';
import 'auth/auth.dart';
import 'helpers.dart';

abstract class YTMusicServices extends AuthMixin {
  YTMusicServices() : super() {
    init();
  }
  Future<void> init() async {
    headers = await loadHeaders();
    context = initializeContext();

    if (!headers.containsKey('X-Goog-Visitor-Id')) {
      headers['X-Goog-Visitor-Id'] = await getVisitorId(headers) ?? '';
    }
  }

  refreshContext() {
    context = initializeContext();
  }

  Future<void> refreshHeaders() async {
    headers = await loadHeaders();
  }

  Future<void> resetVisitorId() async {
    Map<String, String> newHeaders = Map.from(headers);
    newHeaders.remove('X-Goog-Visitor-Id');
    refreshHeaders();
  }

  static const ytmDomain = 'music.youtube.com';
  static const httpsYtmDomain = 'https://music.youtube.com';
  static const baseApiEndpoint = '/youtubei/v1/';
  static const String ytmParams =
      '?alt=json&key=AIzaSyC9XL3ZjWddXya6X74dJoCTL-WEYFDNX30';
  static const userAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:88.0) Gecko/20100101 Firefox/88.0';

  Map<String, String> headers = {};
  int? signatureTimestamp;
  Map<String, dynamic> context = {};

  Future<Response> sendGetRequest(
    String url,
    Map<String, String>? headers,
  ) async {
    final Uri uri = Uri.parse(url);
    final Response response = await get(uri, headers: headers);
    return response;
  }

  Future<String?> getVisitorId(Map<String, String>? headers) async {
    final response = await sendGetRequest(httpsYtmDomain, headers);
    final reg = RegExp(r'ytcfg\.set\s*\(\s*({.+?})\s*\)\s*;');
    final matches = reg.firstMatch(response.body);
    String? visitorId;
    if (matches != null) {
      final ytcfg = json.decode(matches.group(1).toString());
      visitorId = ytcfg['VISITOR_DATA']?.toString();
    }
    return visitorId;
  }

  Future<Map<String, dynamic>> sendRequest(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers, String additionalParams = ''}) async {
    //
    body = {...body, ...context};
    // pprint(body);

    this.headers.addAll(headers ?? {});
    // pprint(this.headers);
    final Uri uri = Uri.parse(httpsYtmDomain +
        baseApiEndpoint +
        endpoint +
        ytmParams +
        additionalParams);
    final response =
        await post(uri, headers: this.headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {};
    }
  }
}
