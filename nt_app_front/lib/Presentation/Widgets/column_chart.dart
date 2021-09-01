import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nt_app_front/Model/stocks.dart';
import 'package:nt_app_front/Presentation/Screens/Hompage/controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnChart extends StatefulWidget {
  const ColumnChart({Key? key}) : super(key: key);

  @override
  _ColumnChartState createState() => _ColumnChartState();
}

class _ColumnChartState extends State<ColumnChart> {
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    // _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Get.find<HomePageViewController>().chartData == null
        ? Text('No Data')
        : Container(
            child: SfCartesianChart(
              title: ChartTitle(text: 'sales analysis'),
              // legend: Legend(isVisible: true),
              tooltipBehavior: _tooltipBehavior,
              series: <ChartSeries>[
                ColumnSeries<ChartData, double>(
                    dataSource: Get.find<HomePageViewController>().chartData!,
                    xValueMapper: (ChartData sales, _) =>
                        sales.date!.year.toDouble(),
                    yValueMapper: (ChartData sales, _) => sales.close,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    width: 0.8, // Width of the columns
                    spacing: 0.2,
                    enableTooltip: true)
              ],
              primaryXAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                // interval: 2,
                // minimum: 2020,
              ),
              primaryYAxis: NumericAxis(
                  // labelFormat: '{value}M',
                  numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
            ),
          );
  }
}
