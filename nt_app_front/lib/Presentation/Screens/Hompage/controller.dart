import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nt_app_front/API/company.dart';
import 'package:nt_app_front/API/history.dart';
import 'package:nt_app_front/API/stock.dart';
import 'package:nt_app_front/Model/company.dart';
import 'package:nt_app_front/Model/stocks.dart';
import 'package:nt_app_front/Services/auth_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePageViewController extends GetxController {
  @override
  Future<void> onInit() async {
    // chartData = getChartData();
    await getUserHistory();
    trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.onInit();
  }

  String? token;
  Rx<DateTime> start = DateTime.now().obs;
  Rx<DateTime> end = DateTime.now().obs;
  late List<ChartData>? chartData;
  late TrackballBehavior trackballBehavior;
  Company? c;
  var isCompany = false.obs;
  TextEditingController searchFieldController = TextEditingController();
  var selectedChart = "OHLC".obs;
  var selectedTime = 1.obs;
  var gettingCompanyDetails = false.obs;

  var companySelected = ''.obs;

  void updateStartDate(date) {
    start.update((val) {
      start.value = date;
    });
  }

  void updateEndDate(date) {
    end.update((val) {
      end.value = date;
    });
  }

  Future<void> fetchCompanyDetails() async {
    // if (companySelected.value == '') return;
    isCompany.update((val) {
      isCompany.value = false;
    });
    gettingCompanyDetails.update((val) {
      gettingCompanyDetails.value = true;
    });
    try {
      c = await CompanyApi.getCompanyDetails(
          companyName: companySelected.value);
      gettingCompanyDetails.update((val) {
        gettingCompanyDetails.value = false;
      });
      if (c == null)
        isCompany.update((val) {
          isCompany.value = false;
        });
      else
        isCompany.update((val) {
          isCompany.value = true;
        });
    } catch (e) {
      print(e);
    }
  }

  Future<void> companyChanged(String newCompany) async {
    if (newCompany == companySelected.value) return;
    try {
      companySelected.update((val) {
        companySelected.value = newCompany;
      });
      await fetchCompanyDetails();
      await getChartData();
    } catch (e) {}
  }

  Future<void> onSearch() async {
    await addUserHistory();
    companyChanged(searchFieldController.text);
  }

  void updateSelectedChart(String newVal) {
    selectedChart.update((val) {
      selectedChart.value = newVal;
    });
  }

  void updateSelectedTime(int newVal) {
    selectedTime.update((val) {
      selectedTime.value = newVal;
    });
  }

  List<String> chartTypes = [
    "OHLC",
    "Candlesticks",
    "Colored Bar",
    "Vertex Line",
    "Hollow Candle",
  ];

  List<int> timeTypes = [
    1,
    7,
    31,
  ];

  var isLoadingChartData = false.obs;

  Future<List<ChartData>?> getChartData() async {
    isLoadingChartData.update((val) {
      isLoadingChartData.value = true;
    });
    print('Loading charts');
    var x = await StockApi.getStocks(
        symbol: searchFieldController.text.toUpperCase(),
        start_date: DateFormat('yyyy-MM-dd').format(start.value),
        end_date: DateFormat('yyyy-MM-dd').format(end.value),
        interval: selectedTime.value.toString(),
        token: Get.find<AuthenticationService>().idToken.value);
    chartData = x?.datapoints;
    isLoadingChartData.update((val) {
      isLoadingChartData.value = false;
    });
    return chartData;
  }

  Future<void> addUserHistory() async {
    if (Get.find<AuthenticationService>().idToken.value != '') {
      isLoadingUserHistory.update((val) {
        isLoadingUserHistory.value = true;
      });
      print('reading');
      userHistory = await HistoryApi.postHistory(
        token: Get.find<AuthenticationService>().idToken.value,
        symbol: searchFieldController.text.toUpperCase(),
      );
      isLoadingUserHistory.update((val) {
        isLoadingUserHistory.value = false;
      });
    }
  }

  List<String>? userHistory = [];
  var isLoadingUserHistory = true.obs;
  Future<void> getUserHistory() async {
    print('trying');
    if (Get.find<AuthenticationService>().idToken.value != '') {
      isLoadingUserHistory.update((val) {
        isLoadingUserHistory.value = true;
      });
      print('akinf');
      userHistory = await HistoryApi.getHistory(
          token: Get.find<AuthenticationService>().idToken.value);
      isLoadingUserHistory.update((val) {
        isLoadingUserHistory.value = false;
      });
    }
  }
}
