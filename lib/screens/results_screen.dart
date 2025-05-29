import 'package:dna_analyse/generated/l10n.dart';

import 'package:dna_analyse/screens/view/results/results_analysis_informations.dart';
import 'package:dna_analyse/screens/view/results/results_buttons.dart';
import 'package:dna_analyse/screens/view/results/results_gridView.dart';
import 'package:dna_analyse/services/loading_data.dart';
import 'package:dna_analyse/widgets/ai_button.dart';

import 'package:dna_analyse/widgets/mainWidgets.dart';
import 'package:flutter/material.dart';

class ResultsView extends StatefulWidget {
  const ResultsView({super.key});
  static get risk => null;
  @override
  State<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  //final score = (100 - (analysisResult.healthRisk.riskScore * 100));
  late Future<Map<String, dynamic>> futureAnalysis;

  final healthyPercent =
      (ResultsView.risk != null
          ? 100 - (ResultsView.risk.riskScore * 100).toInt()
          : 0);

  final riskPercent =
      (ResultsView.risk != null
          ? (ResultsView.risk.riskScore * 100).toInt()
          : 0);

  late ScrollController scrollController;

  bool showAppBarTitle = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      final isScrolled = scrollController.offset > 10;
      if (isScrolled != showAppBarTitle) {
        setState(() {
          showAppBarTitle = isScrolled;
        });
      }
    });

    futureAnalysis = JsonService.fetchDnaAnalysis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Customdrawer(),
      appBar: AppBar(
        title:
            scrollController.hasClients && scrollController.offset > 10
                ? Text(
                  S.of(context).results,
                  style: Theme.of(context).textTheme.headlineSmall,
                )
                : null,
        actions: [AiAssistant()],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futureAnalysis,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
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
            );
          }
          final data = snapshot.data!;
          final analysesInformation =
              data['analysisResult']['analysesInformation'];
          final dynamic results = data['analysisResult'];
          return Scrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: Text(
                      S.of(context).results,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  AnalysisInformationCard(result: analysesInformation),
                  MedicationsMeasuresButton(),
                  HealthIstatisticButton(results: results),
                  SummeryButton(results: results),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),

                  // Quick Actions
                  Text(
                    S.of(context).quickActions,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  quickActions(context, results),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
