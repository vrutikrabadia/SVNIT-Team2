import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nt_app_front/Model/stocks.dart';
import 'package:nt_app_front/Presentation/Screens/Hompage/controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VertexLineChart extends StatefulWidget {
  const VertexLineChart({Key? key}) : super(key: key);

  @override
  _VertexLineChartState createState() => _VertexLineChartState();
}

class _VertexLineChartState extends State<VertexLineChart> {
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
                LineSeries<ChartData, double>(
                    dataSource: Get.find<HomePageViewController>().chartData!,
                    xValueMapper: (ChartData sales, _) =>
                        sales.date!.year.toDouble(),
                    yValueMapper: (ChartData sales, _) => sales.close,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true)
              ],
              primaryXAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  // interval: 2,
                  // minimum: 2021,

                  majorGridLines: MajorGridLines(width: 2)),
              primaryYAxis: NumericAxis(
                  labelFormat: '{value}M',
                  numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
            ),
          );
  }
}
