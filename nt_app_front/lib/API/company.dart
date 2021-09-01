import 'package:http/http.dart' as http;
import 'package:nt_app_front/Model/company.dart';

class CompanyApi {
  static Future<Company?> getCompanyDetails(
      {required String companyName}) async {
    final String url =
        "https://cloud.iexapis.com/stable/stock/$companyName/company/tops?token=pk_65aa443ba982403e8ad3681e7e7f0993";
    var client = http.Client();
    Company? companyDetails;
    try {
      var uriResponse = await client.get(
        Uri.parse(url),
      );
      if (uriResponse.statusCode == 200) {
        var jsonString = uriResponse.body;
        companyDetails = companyFromJson(jsonString);
      }
      return companyDetails;
    } finally {
      client.close();
    }
  }
}
