import 'dart:math';

import 'package:crm_spx/src/pages/dashboard/components/simple_view.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarreChart extends StatefulWidget {
  const BarreChart({ Key? key }) : super(key: key);

  @override
  _BarreChartState createState() => _BarreChartState();
}

class _BarreChartState extends State<BarreChart> {

  /// Specifies the list of chart sample data.
  List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: 1, y: 30),
    ChartSampleData(x: 3, y: 13),
    ChartSampleData(x: 5, y: 80),
    ChartSampleData(x: 7, y: 30),
    ChartSampleData(x: 9, y: 72)
  ];

  /// Creates an instance of random to generate the random number.
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: SfCartesianChart(
          primaryXAxis: NumericAxis(),
          primaryYAxis: NumericAxis(),
          series: <ColumnSeries<ChartSampleData, num>>[
            ColumnSeries<ChartSampleData, num>(
                dataSource: chartData,
                xValueMapper: (ChartSampleData data, _) => data.x,
                yValueMapper: (ChartSampleData data, _) => data.y,
                dataLabelSettings: const DataLabelSettings(isVisible: true)),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          chartData = <ChartSampleData>[];
          chartData = _getChartData();
        }),
        child: const Icon(Icons.refresh, color: Colors.white),
      )
    );
  }

  /// Get the random value.
  num _getRandomInt(int min, int max) {
    return min + random.nextInt(max - min);
  }

  /// Method to update the chart data.
  List<ChartSampleData> _getChartData() {
    chartData.add(ChartSampleData(x: 1, y: _getRandomInt(10, 100)));
    chartData.add(ChartSampleData(x: 3, y: _getRandomInt(10, 100)));
    chartData.add(ChartSampleData(x: 5, y: _getRandomInt(10, 100)));
    chartData.add(ChartSampleData(x: 7, y: _getRandomInt(10, 100)));
    chartData.add(ChartSampleData(x: 9, y: _getRandomInt(10, 100)));
    return chartData;
  }
}

