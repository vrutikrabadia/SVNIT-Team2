import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';

class HistoryApi {
  static Future<List<String>?> getHistory({
    required String token,
  }) async {
    final String url = AppConfig.baseUrl + "/find_history";
    var client = http.Client();
    List<String>? history;
    print(token);
    try {
      var uriResponse = await client.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );
      history = historyFromJson(uriResponse.body);

      return history;
    } finally {
      client.close();
    }
  }

  static Future<List<String>?> postHistory({
    required String token,
    required String symbol,
  }) async {
    final String url = AppConfig.baseUrl + "/add_history";
    var client = http.Client();
    HistoryResponse history;
    print(token);
    try {
      var uriResponse = await client.post(Uri.parse(url),
          headers: {"Authorization": "Bearer $token"}, body: {"stock": symbol});
      history = historyResponseFromJson(uriResponse.body);
      return history.watchlist;
    } finally {
      client.close();
    }
  }
}

List<String> historyFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));

// To parse this JSON data, do
//
//     final historyResponse = historyResponseFromJson(jsonString);

HistoryResponse historyResponseFromJson(String str) =>
    HistoryResponse.fromJson(json.decode(str));

String historyResponseToJson(HistoryResponse data) =>
    json.encode(data.toJson());

class HistoryResponse {
  HistoryResponse({
    this.watchlist,
  });

  List<String>? watchlist;

  factory HistoryResponse.fromJson(Map<String, dynamic> json) =>
      HistoryResponse(
        watchlist: json["watchlist"] == null
            ? null
            : List<String>.from(json["watchlist"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "watchlist": watchlist == null
            ? null
            : List<dynamic>.from(watchlist!.map((x) => x)),
      };
}
