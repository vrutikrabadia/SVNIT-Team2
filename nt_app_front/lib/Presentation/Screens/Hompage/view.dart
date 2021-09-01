import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_front/Presentation/Screens/Hompage/controller.dart';
import 'package:nt_app_front/Presentation/Screens/LoginPage/view.dart';
import 'package:nt_app_front/Presentation/Widgets/column_chart.dart';
import 'package:nt_app_front/Presentation/Widgets/company_profile.dart';
import 'package:nt_app_front/Presentation/Widgets/candlestick_chart.dart';
import 'package:nt_app_front/Presentation/Widgets/ohlc_chart.dart';
import 'package:nt_app_front/Presentation/Widgets/radio_buttons_chart.dart';
import 'package:nt_app_front/Presentation/Widgets/radio_buttons_time.dart';
import 'package:nt_app_front/Presentation/Widgets/vertex_line_chart.dart';
import 'package:nt_app_front/Services/auth_service.dart';

class HomePage extends GetView<HomePageViewController> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomePageViewController());
    return Scaffold(
      appBar: AppBar(title: Text('Northern Trust')),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => ElevatedButton(
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2001),
                                      lastDate: DateTime(2022))
                                  .then((value) =>
                                      controller.updateStartDate(value));
                            },
                            child: Text(
                              controller.start.value.toString(),
                            ),
                          ),
                        ),
                        Obx(
                          () => ElevatedButton(
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2001),
                                      lastDate: DateTime(2022))
                                  .then((value) =>
                                      controller.updateEndDate(value));
                            },
                            child: Text(
                              controller.end.value.toString(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Obx(() => controller.isCompany.value == true
                          ? (controller.c?.companyName == null
                              ? Center(
                                  child: Text(
                                  'No such company',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                              // : controller.gettingCompanyDetails.value == true
                              : controller.isLoadingChartData.value == true
                                  ? Center(child: CircularProgressIndicator())
                                  : makeChart(controller.selectedChart.value))
                          : Text('No company')),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          TextField(
                            controller: controller.searchFieldController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () async {
                                  await controller.onSearch();
                                },
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(child: RadioSelection()),
                              Expanded(child: RadioSelectionTime()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => controller.gettingCompanyDetails.value == true
                            ? Center(child: CircularProgressIndicator())
                            : CompanyProfile(),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => Get.find<AuthenticationService>().idToken.value ==
                                ''
                            ? Column(
                                children: [
                                  Text('You are not logged in'),
                                  ElevatedButton(
                                      onPressed: () =>
                                          Get.offAll(() => LoginPage()),
                                      child: Text('Login'))
                                ],
                              )
                            : Container(
                                child: Column(
                                  children: [
                                    Text(
                                      'History',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Obx(() => controller
                                                .isLoadingUserHistory.value ==
                                            true
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Column(
                                            children: controller.userHistory!
                                                .map((e) {
                                              return Text(e);
                                            }).toList(),
                                          ))
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeChart(String chartName) {
    if (chartName == 'Candlesticks')
      return CandleStickChart(
        chartData: controller.chartData!,
        isSolid: true,
        trackballBehavior: controller.trackballBehavior,
        stockName: controller.searchFieldController.text,
      );
    else if (chartName == 'OHLC')
      return OhlcChart(
        chartData: controller.chartData!,
        trackballBehavior: controller.trackballBehavior,
        stockName: controller.searchFieldController.text,
      );
    else if (chartName == 'Colored Bar')
      return ColumnChart();
    else if (chartName == 'Vertex Line') return VertexLineChart();
    return CandleStickChart(
      chartData: controller.chartData!,
      isSolid: false,
      trackballBehavior: controller.trackballBehavior,
      stockName: controller.searchFieldController.text,
    );
  }
}
