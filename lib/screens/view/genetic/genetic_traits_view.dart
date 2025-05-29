import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/services/loading_data.dart';
import 'package:dna_analyse/utils/AppTheme.dart';
import 'package:dna_analyse/widgets/buildSectionTitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:genetic_test/models/AnalysisResult.dart';

class GeneticTrait {
  final String title;
  final String result;
  final String gene;
  final String prevalence;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> implications;

  GeneticTrait({
    required this.title,
    required this.result,
    required this.gene,
    required this.prevalence,
    required this.description,
    required this.icon,
    required this.color,
    required this.implications,
  });
}

class GeneticTraitsScreen extends StatefulWidget {
  const GeneticTraitsScreen({super.key});

  @override
  State<GeneticTraitsScreen> createState() => _GeneticTraitsScreenState();
}

class _GeneticTraitsScreenState extends State<GeneticTraitsScreen> {
  final ScrollController _scrollController = ScrollController();
  late Future<Map<String, dynamic>> futureAnalysis;

  // final List<Traits> _traits = analysisResult.geneticTraits.traits;
  final String dnaLogo = "assets/images/dnawhite.png";
  //GeneticTraitsScreen()

  @override
  void initState() {
    super.initState();

    futureAnalysis = JsonService.fetchDnaAnalysis();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: FutureBuilder(
        future: futureAnalysis,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text('Hata: ${snapshot.error}'),
                ],
              ),
            );
          }
          final data = snapshot.data!;
          final results = data['analysisResult'];

          return Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        dnaLogo,
                        width: 50,
                        height: 50,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      SizedBox(width: 16),
                      _buildHeader(isDarkMode),
                    ],
                  ),
                  SizedBox(height: 24),
                  _buildDetailedTraits(results),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailedTraits(dynamic results) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final trait = results["geneticTraits"];
    final List<dynamic> traitsList = results["geneticTraits"]["traits"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).detailedAnalysis,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[900],
          ),
        ),
        SizedBox(height: 16),
        ...traitsList.map((trait) {
          return _buildTraitExpansion(
            GeneticTrait(
              title: trait['title'],
              result: trait['result'],
              gene: trait['gene'],
              prevalence: trait['prevalence'],
              description: trait['description'],
              icon: FontAwesomeIcons.dna, // bunu dinamik hale getirebilirsin
              color: Colors.blue,
              implications: List<String>.from(trait['implications']),
            ),
            isDarkMode,
            results,
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTraitExpansion(dynamic trait, bool isDarkMode, dynamic results) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // Removes the divider
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 16),
          childrenPadding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          title: Text(
            trait.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            trait.result,
            style: TextStyle(color: Colors.blueAccent),
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gene",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    trait.gene,
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                _buildTraitDetail(S.of(context).prevalence, trait.prevalence),
                SizedBox(height: 12),
                Text(
                  S.of(context).description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(trait.description),
                SizedBox(height: 12),
                Text(
                  S.of(context).implications,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 4),
                ...trait.implications.map(
                  (imp) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: isDarkMode ? Colors.blue : Colors.blue,
                        ),
                        SizedBox(width: 8),
                        Expanded(child: Text(imp)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                if (trait.title == "Earwax Type") _buildEarwaxChart(isDarkMode),
                if (trait.title == "Taste Perception")
                  _buildTasteChart(results),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              S.of(context).yourGeneticTraits,

              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.grey[600] : Colors.black,
              ),
            ),
          ],
        ),
        Text(
          S.of(context).dnaAnalysisResults,
          style: TextStyle(
            fontSize: 16,
            color: isDarkMode ? Colors.grey[200] : Colors.grey[900],
          ),
        ),
      ],
    );
  }

  Widget _buildTraitDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 1),
        Text(value, style: TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildEarwaxChart(bool isDarkMode) {
    String ethnicity = "East Asian";
    String ethnicityPossibility = "80-90%";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          S.of(context).globalDistribution,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 8),

        GFProgressBar(
          percentage: 0.5,
          backgroundColor: const Color.fromARGB(255, 50, 54, 70),
          lineHeight: 20,
          progressBarColor: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$ethnicity $ethnicityPossibility",
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Other 5-20%",
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }

  Widget _buildTasteChart(dynamic results) {
    Map<String, double> tasteData = {
      'Non-Taster': 0.3,
      'Medium': 0.4,
      'Super-Taster': 0.3,
    };
    // final List<Traits> data = analysisResult.geneticTraits.traits;
    final dynamic data = results["geneticTraits"]["traits"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          S.of(context).tasteSensitivitySpectrum,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),

        CustomProgressBar(data: tasteData),
      ],
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  final Map<String, double> data;

  const CustomProgressBar({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final double radius = 9;
    final totalWidth = 350.0;
    final List<Color> colors = [Colors.green, Colors.blue, Colors.red];
    final entries = data.entries.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress bar
        SizedBox(
          height: 10,
          width: totalWidth,
          child: Row(
            children: List.generate(entries.length, (index) {
              final value = entries[index].value;
              final isFirst = index == 0;
              final isLast = index == entries.length - 1;
              return Expanded(
                flex: (value * 100).toInt(),
                child: Container(
                  decoration: BoxDecoration(
                    color: colors[index % colors.length],
                    borderRadius: BorderRadius.horizontal(
                      left: isFirst ? Radius.circular(radius) : Radius.zero,
                      right: isLast ? Radius.circular(radius) : Radius.zero,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 4),
        // Labels and percentages
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(entries.length, (index) {
            final entry = entries[index];
            return Expanded(
              flex: (entry.value * 100).toInt(),
              child: Column(
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "${(entry.value * 100).toStringAsFixed(1)}%",
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
