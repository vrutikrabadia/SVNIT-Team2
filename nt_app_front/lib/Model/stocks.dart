// To parse this JSON data, do
//
//     final stocksResult = stocksResultFromJson(jsonString);

import 'dart:convert';

StocksResult stocksResultFromJson(String str) =>
    StocksResult.fromJson(json.decode(str));

String stocksResultToJson(StocksResult data) => json.encode(data.toJson());

class StocksResult {
  StocksResult({
    this.datapoints,
  });

  List<ChartData>? datapoints;

  factory StocksResult.fromJson(Map<String, dynamic> json) => StocksResult(
        datapoints: json["datapoints"] == null
            ? null
            : List<ChartData>.from(
                json["datapoints"].map((x) => ChartData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "datapoints": datapoints == null
            ? null
            : List<dynamic>.from(datapoints!.map((x) => x.toJson())),
      };
}

class ChartData {
  ChartData({
    this.high,
    this.low,
    this.open,
    this.close,
    this.date,
  });

  double? high;
  double? low;
  double? open;
  double? close;
  DateTime? date;

  factory ChartData.fromJson(Map<String, dynamic> json) => ChartData(
        high: json["high"] == null ? null : json["high"].toDouble(),
        low: json["low"] == null ? null : json["low"].toDouble(),
        open: json["open"] == null ? null : json["open"].toDouble(),
        close: json["close"] == null ? null : json["close"].toDouble(),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "high": high == null ? null : high,
        "low": low == null ? null : low,
        "open": open == null ? null : open,
        "close": close == null ? null : close,
        "date": date == null ? null : date!.toIso8601String(),
      };
}
