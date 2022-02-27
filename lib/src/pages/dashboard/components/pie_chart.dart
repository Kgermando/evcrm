import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  const PieChart({Key? key}) : super(key: key);

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Sans réponse', 10, '70%'),
      ChartData('appel reçu', 11, '60%'),
      ChartData('Bip', 9, '52%'),
      ChartData('Rappel', 10, '40%')
    ];
    return Center(
        child: SfCircularChart(
          legend: Legend(isVisible: true, isResponsive: true),
          series: <CircularSeries>[
            PieSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              // Segments will explode on tap
              enableTooltip: true,
              explode: true,
              name: 'Statut d\'appels',
              // First segment will be exploded on initial rendering
              explodeIndex: 1)
          ]
        )
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.size);
  final String x;
  final double y;
  final String size;
}
