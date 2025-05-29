import 'dart:math';

import 'package:dna_analyse/models/values.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HealthMetricsScreen extends StatefulWidget {
  const HealthMetricsScreen({super.key});

  @override
  State<HealthMetricsScreen> createState() => _HealthMetricsScreenState();
}

class _HealthMetricsScreenState extends State<HealthMetricsScreen> {
  //late TooltipBehavior _tooltipBehavior;

  // @override
  // void initState() {
  //   super.initState();
  //   _tooltipBehavior = TooltipBehavior(
  //     enable: true,
  //     format: 'point.x : point.y',
  //     canShowMarker: true,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sağlık Metrikleri')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _buildMetricChart(
              'Kalp Atışı (BPM)',
              generateData('pulse').cast<ChartData>(),
              Colors.red,
            ),
            const SizedBox(height: 20),
            _buildMetricChart(
              'Kan Basıncı (mmHg)',
              generateData('bloodPressure').cast<ChartData>(),
              Colors.blue,
            ),
            const SizedBox(height: 20),
            _buildMetricChart(
              'Uyku (Saat)',
              generateData('sleep').cast<ChartData>(),
              Colors.purple,
            ),
            const SizedBox(height: 20),
            _buildMetricChart(
              'Şeker Seviyesi (mg/dL)',
              generateData('sugar').cast<ChartData>(),
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricChart(String title, List<ChartData> data, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            Divider(),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: SfCartesianChart(
                margin: EdgeInsets.zero,
                primaryXAxis: CategoryAxis(
                  labelPlacement: LabelPlacement.onTicks,
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                ),
                // borderWidth: 0,
                // borderColor: Colors.transparent,
                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                    text: title.split('(').last.replaceAll(')', ''),
                  ),
                ),
                //tooltipBehavior: _tooltipBehavior,
                series: [
                  SplineSeries<ChartData, String>(
                    dataSource: data,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    color: color,
                    width: 3,
                    markerSettings: const MarkerSettings(isVisible: true),
                    name: title.split('(').first.trim(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Minichart extends StatelessWidget {
//   const Minichart({super.key, required this.data, required this.color});

//   final List<ChartData> data;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       width: 150,
//       child: SfCartesianChart(
//         margin: EdgeInsets.zero,
//         primaryXAxis: CategoryAxis(
//           isVisible: false, //
//           labelPlacement: LabelPlacement.onTicks,
//           edgeLabelPlacement: EdgeLabelPlacement.shift,
//         ),
//         plotAreaBorderWidth: 0.0,
//         primaryYAxis: NumericAxis(isVisible: false),

//         series: [
//           //LineSeries
//           SplineSeries<ChartData, String>(
//             dataSource: data,
//             // _generateHeartRateData(),
//             xValueMapper: (ChartData data, _) => data.x,
//             yValueMapper: (ChartData data, _) => data.y,
//             color: color,
//             width: 3,
//             markerSettings: const MarkerSettings(isVisible: false),
//           ),
//         ],
//       ),
//     );
//   }
// }
