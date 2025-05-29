import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/data.dart';
import 'package:dna_analyse/screens/view/summery/summery_healthStatus.dart';
import 'package:dna_analyse/screens/view/results/results_analysis_informations.dart';
import 'package:dna_analyse/screens/view/results/results_buttons.dart';
import 'package:flutter/material.dart';

class SummeryView extends StatelessWidget {
  const SummeryView({super.key, required this.results});
  final dynamic results;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Summary,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SummeryHealthStatus(
                risk: analysisResult.healthRisk,
                isDark: true,
              ),
              //KeyFindings(data: analysisResult.analysesInformation),
              MedicationsMeasuresButton(),
            ],
          ),
        ),
      ),
    );
  }
}
