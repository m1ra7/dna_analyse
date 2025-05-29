import 'package:dna_analyse/screens/view/genetic/dna_overview.dart';
import 'package:dna_analyse/screens/view/genetic/genetic_info.dart';
import 'package:dna_analyse/services/loading_data.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';

class GeneticTraitsView extends StatefulWidget {
  const GeneticTraitsView({super.key});
  @override
  State<GeneticTraitsView> createState() => _GeneticTraitsViewState();
}

class _GeneticTraitsViewState extends State<GeneticTraitsView> {
  late Future<Map<String, dynamic>> futureAnalysis;

  @override
  void initState() {
    super.initState();

    futureAnalysis = JsonService.fetchDnaAnalysis();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.grey[500]! : Colors.grey.shade800;
    final valuetextColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
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
              ),
            );
          }
          final data = snapshot.data!;
          final result = data['analysisResult'];

          return Scrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DnaOverview(),
                  buildGeneticTraitsCard(
                    context,
                    textColor,
                    valuetextColor,
                    result,
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
