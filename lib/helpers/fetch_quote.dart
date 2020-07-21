import 'dart:convert';

import 'package:http/http.dart' as http;

List<String> allTags = ["wisdom", "life", "technology"];

Future<Map<String, String>> getRandomQuote({String tag = "wisdom"}) async {
  final String url = "http://api.quotable.io/random?tags=$tag";

  final http.Response res = await http.get(url);

  final Map jsonResponse = jsonDecode(res.body) as Map;

  return {
    "quoteKey": jsonResponse['_id'] as String,
    "quote": jsonResponse['content'] as String,
    "author": jsonResponse['author'] as String,
  };
}
