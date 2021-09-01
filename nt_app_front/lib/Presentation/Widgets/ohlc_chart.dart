import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nt_app_front/Model/stocks.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OhlcChart extends StatefulWidget {
  const OhlcChart({
    Key? key,
    required this.trackballBehavior,
    required this.chartData,
    required this.stockName,
  }) : super(key: key);

  final TrackballBehavior trackballBehavior;
  final List<ChartData>? chartData;
  final String stockName;

  @override
  _OhlcChartState createState() => _OhlcChartState();
}

class _OhlcChartState extends State<OhlcChart> {
  @override
  Widget build(BuildContext context) {
    return widget.chartData == null
        ? Text('No Data')
        : Container(
            child: SfCartesianChart(
              title: ChartTitle(text: '${widget.stockName} - 2016'),
              // legend: Legend(isVisible: true),
              trackballBehavior: widget.trackballBehavior,
              series: <HiloOpenCloseSeries>[
                HiloOpenCloseSeries<ChartData, DateTime>(
                  dataSource: widget.chartData!,
                  xValueMapper: (ChartData sales, _) => sales.date,
                  lowValueMapper: (ChartData sales, _) => sales.low,
                  highValueMapper: (ChartData sales, _) => sales.high,
                  openValueMapper: (ChartData sales, _) => sales.open,
                  closeValueMapper: (ChartData sales, _) => sales.close,
                )
              ],
              primaryXAxis: DateTimeAxis(
                  // dateFormat: DateFormat.MMM(),
                  majorGridLines: MajorGridLines(width: 2)),
              primaryYAxis: NumericAxis(
                // minimum: 70,
                // maximum: 130,
                // interval: 10,
                numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
              ),
            ),
          );
  }
}
