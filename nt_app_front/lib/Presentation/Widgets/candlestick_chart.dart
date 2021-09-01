import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nt_app_front/Model/stocks.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CandleStickChart extends StatefulWidget {
  const CandleStickChart({
    Key? key,
    required this.trackballBehavior,
    required this.chartData,
    required this.isSolid,
    required this.stockName,
  }) : super(key: key);

  final TrackballBehavior trackballBehavior;
  final List<ChartData>? chartData;
  final bool isSolid;
  final String stockName;

  @override
  _CandleStickChartState createState() => _CandleStickChartState();
}

class _CandleStickChartState extends State<CandleStickChart> {
  @override
  Widget build(BuildContext context) {
    return widget.chartData == null
        ? Text('No Data')
        : Container(
            child: SfCartesianChart(
              title: ChartTitle(text: '${widget.stockName}'),
              // legend: Legend(isVisible: true),
              trackballBehavior: widget.trackballBehavior,
              series: <CandleSeries>[
                CandleSeries<ChartData, DateTime>(
                    enableSolidCandles: widget.isSolid,
                    dataSource: widget.chartData!,
                    xValueMapper: (ChartData sales, _) => sales.date,
                    lowValueMapper: (ChartData sales, _) => sales.low,
                    highValueMapper: (ChartData sales, _) => sales.high,
                    openValueMapper: (ChartData sales, _) => sales.open,
                    closeValueMapper: (ChartData sales, _) => sales.close)
              ],
              primaryXAxis: DateTimeAxis(
                // dateFormat: DateFormat.d(),
                majorGridLines: MajorGridLines(width: 2),

                // minimum: DateTime(2016, 1, 1),
              ),
              primaryYAxis: NumericAxis(
                  // minimum: 70,
                  // maximum: 130,
                  // interval: 10,
                  numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
            ),
          );
  }
}
