import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/values.dart';
import 'package:dna_analyse/screens/view/health/dashboard_health_metrics_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/*
"Recent Analyses"
"7445Sample DNA Analysis with Know Markers",
"Analysis of sample DNA sequence with known genetic markers for demonstration purposes."


Detailed health risk analysis.__
----

Rheumatoid arthritis.

Moderate genetic risk for rheumatoid arthritis based HLA complex variants

Recommendations:
-joint-supportive exercise.
-regular monitoring
-anti-inflammatory diet.
-vitamin d supplementation

genetic Markers:
HLA-DRB1 PTPN22 STAT4

*/

class healthstats extends StatefulWidget {
  const healthstats({super.key});

  @override
  State<healthstats> createState() => _healthstatsState();
}

class _healthstatsState extends State<healthstats> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      format: 'point.x : point.y',
      canShowMarker: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HealthMetricsScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cardWidgetKey.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(1.0),
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                cardWidgetKey[index]["currentValue"].toString(),
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              Text(
                                " ${cardWidgetKey[index]["unit"]}",
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall?.copyWith(
                                  color: Colors.grey.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 200,
                            height: 60,
                            child: cardWidgetKey[index]["grafik"] as Widget?,
                          ),
                          Text(
                            cardWidgetKey[index]["title"].toString(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTrendIndicator(Trend trend) {
    IconData icon;
    Color color;

    switch (trend) {
      case Trend.up:
        icon = Icons.trending_up;
        color = Colors.green;
        break;
      case Trend.down:
        icon = Icons.trending_down;
        color = Colors.red;
        break;
      case Trend.stable:
        icon = Icons.trending_flat;
        color = Colors.blue;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            trend == Trend.up
                ? "Artış"
                : trend == Trend.down
                ? "Düşüş"
                : "Sabit",
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      ),
    );
  }
}

class widgetCard extends StatelessWidget {
  const widgetCard({
    super.key,
    required this.color,
    this.isVisible = true,
    this.plotAreaBorderWidt = 0.1,
    required this.type,
  });

  //final List<ChartData> data;
  final Color color;
  final bool isVisible;
  final double plotAreaBorderWidt;
  final XyDataSeries type;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          width: 150,
          child: SfCartesianChart(
            margin: EdgeInsets.zero,
            primaryXAxis: CategoryAxis(
              isVisible: isVisible, //
              labelPlacement: LabelPlacement.onTicks,
              edgeLabelPlacement: EdgeLabelPlacement.shift,
            ),
            plotAreaBorderWidth: plotAreaBorderWidt,
            primaryYAxis: NumericAxis(isVisible: isVisible),
            tooltipBehavior: tooltipBehavior._tooltipBehavior,
            series: [type],
          ),
        ),
      ],
    );
  }
}

mixin tooltipBehavior {
  static final TooltipBehavior _tooltipBehavior = TooltipBehavior(
    enable: true,
    format: 'point.x : point.y',
    canShowMarker: true,
  );
}

enum Trend { up, down, stable }
