import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/values.dart';
import 'package:dna_analyse/screens/view/health/widgets/health_basic_health_measurements.dart';
import 'package:dna_analyse/screens/view/health/widgets/health_riskview.dart';
import 'package:dna_analyse/services/loading_data.dart';
import 'package:dna_analyse/screens/view/health/widgets/health_widget.dart';
import 'package:dna_analyse/screens/view/health/detailed_health_analysis.dart';
import 'package:flutter/material.dart';

class HealthIstatistic extends StatefulWidget {
  const HealthIstatistic({super.key, required this.results});
  final dynamic results;

  @override
  State<HealthIstatistic> createState() => _HealthIstatisticState();
}

class _HealthIstatisticState extends State<HealthIstatistic> {
  late Future<Map<String, dynamic>> futureAnalysis;

  @override
  void initState() {
    super.initState();
    futureAnalysis = JsonService.fetchDnaAnalysis();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    final keyHealthMetrics = keyMetrics(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).yourHealthStatus,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: FutureBuilder(
        future: futureAnalysis,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 64, color: Colors.red),
                        SizedBox(height: 16),
                        Text(
                          'Hata: ${snapshot.error}',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          final data = snapshot.data!;
          final dynamic healthRiskData = data['analysisResult']["healthRisk"];
          final Map<String, dynamic> valueHealthMetrics =
              data['analysisResult']["keyHealthMetrics"];
          return Scrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              // padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HealthDashboard(healthRiskData: healthRiskData),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: BasicHealthMeasurements(
                      keyHealthMetrics: keyHealthMetrics,
                      keyHealthMetricsMap: valueHealthMetrics,
                    ),
                  ),
                  GeneticRiskCharts(),
                  HealthChart(
                    view: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailedHealthRadar1(),
                        ),
                      );
                    },
                    analysTyp: getHealthRiskLabels2(context),
                    analysData: getHealthRiskValues2(),
                  ),
                  HealthChart(
                    view: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  DetailedHealthRadar2(results: widget.results),
                        ),
                      );
                    },
                    analysTyp: getHealthRiskLabels(context),
                    analysData: getHealthRiskValues(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
