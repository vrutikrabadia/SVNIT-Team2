import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:nt_app_front/Model/stocks.dart';

import 'config.dart';

class StockApi {
  static Future<StocksResult?> getStocks({
    required String symbol,
    required String start_date,
    required String end_date,
    required String interval,
    required String token,
  }) async {
    final String url = AppConfig.baseUrl + "/get_stock_data";
    var client = http.Client();
    StocksResult? stocks;
    print('Running');
    print(start_date);
    print(end_date);
    try {
      var uriResponse = await client.post(Uri.parse(url), body: {
        "symbol": symbol,
        "start_date": start_date,
        "end_date": end_date,
        "interval": interval,
      }
          // }, headers: {
          // "Authorization": "Bearer $token"
          // }
          );
      print('hi');
      print(uriResponse.body);
      stocks = stocksResultFromJson(uriResponse.body);
      return stocks;
    } finally {
      client.close();
    }
  }
}
