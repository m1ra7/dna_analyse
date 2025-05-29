import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/data.dart';
import 'package:dna_analyse/models/values.dart';
import 'package:dna_analyse/widgets/buildSectionTitle_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final macronutrientData = {
  "Carbohydrates": 40.0,
  "Protein": 30.0,
  "Fats": 20.0,
};

List<ChartData> vitaminMineralNeeds(BuildContext context) {
  final nutrients = getNutrientsWithValues(analysisResult);
  final maxValue = nutrients.fold(
    0,
    (max, e) => e['value'] > max ? e['value'] : max,
  );

  return nutrients
      .map(
        (nutrient) => ChartData(
          nutrient['name'],
          (nutrient['value'] / maxValue * 100)
              .roundToDouble(), // Convert to percentage
        ),
      )
      .toList();
}

List<PieChartSectionData> sections =
    macronutrientData.entries
        .map(
          (entry) => PieChartSectionData(
            value: entry.value,
            title: '${entry.value}%', //:\n${entry.key}',
            color: getColorForMacronutrient(entry.key),
            radius: 67,
            titleStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        )
        .toList();

class NutritionView extends StatelessWidget {
  const NutritionView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.grey[500]! : Colors.grey.shade800;
    final valuetextColor = isDarkMode ? Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          S.of(context).nutrition,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              nutrtitionOverview(context, textColor, valuetextColor),

              NutritionChart(),
              FoodSensitivities(),
              NutritionalRecommendations(),
              BuldNutritionCaloriCard(),
              SizedBox(height: 8),
              Charts(sections: sections),
            ],
          ),
        ),
      ),
    );
  }

  Widget nutrtitionOverview(
    BuildContext context,
    Color textColor,
    Color valuetextColor,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle(
              context,
              S.of(context).nutritionOverview,
              icon: null,
            ),
            const Divider(),
            buildNutritionTable(context, textColor, valuetextColor),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildNutritionTable(
    BuildContext context,
    Color textColor,
    Color valuetextColor,
  ) {
    return Table(
      columnWidths: const {4: FlexColumnWidth(2), 3: FlexColumnWidth(3)},
      children: [
        buildTableRowNutrition(
          S.of(context).metabolicProfile,
          "",
          textColor,
          valuetextColor,
        ),
        buildTableRowNutrition(
          S.of(context).type,
          analysisResult.nutritionProfile.type,
          textColor,
          valuetextColor,
        ), //denge
        buildTableRowNutrition(
          S.of(context).ratio,
          "${analysisResult.nutritionProfile.rate} KCAL",
          textColor,
          valuetextColor,
        ),
        buildTableRowNutrition(
          S.of(context).recommendedDiet,
          analysisResult.nutritionProfile.diet,
          textColor,
          valuetextColor,
        ),
        buildTableRowNutrition(
          S.of(context).mineralNeeds,
          analysisResult.nutritionProfile.mineralNeeds,
          textColor,
          valuetextColor,
        ),
        buildTableRowNutrition(
          S.of(context).vitaminNeeds,
          analysisResult.nutritionProfile.vitaminNeeds,
          textColor,
          valuetextColor,
        ),
        //_buildTableRow( 'Mineral İhtiyaçları', analysisResult.nutritionProfile.diet),
      ],
    );
  }
}

class NutritionalRecommendations extends StatelessWidget {
  const NutritionalRecommendations({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              S.of(context).nutritionalRecommendations,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Divider(),
            Text(
              "- Tam gıdalara odaklanın\n- Susuz kalmayın\n- Vitamin takviyesi almayı düşünün",
            ),
          ],
        ),
      ),
    );
  }
}

class FoodSensitivities extends StatelessWidget {
  const FoodSensitivities({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //buildSectionTitle(S.of(context).foodSensitivities,),
            Text(
              S.of(context).foodSensitivities,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ), //Theme.of(context).textTheme.headlineSmall,
            ),
            Divider(),
            Text("Önemli bir gıda hassasiyeti tespit edilmedi."),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class NutritionChart extends StatelessWidget {
  const NutritionChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Başlık
            Row(
              children: [
                // CircleAvatar(
                //   backgroundColor: Colors.blue.withValues(alpha: 0.1),
                //   child: const Icon(
                //     Icons.abc,
                //     //color: Colors.blue,
                //   ),
                // ),
                //const SizedBox(width: 10),
                Text(
                  S.of(context).vitaminMineralNeeds,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 200,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                //  title: ChartTitle(text: S.of(context).vitaminMineralNeeds),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: [
                  BarSeries<ChartData, String>(
                    dataSource: vitaminMineralNeeds(context),
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    color: Colors.blue,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Tablo benzeri metin listesi
            ...vitaminMineralNeeds(context).map(
              (nutrient) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    //const Icon(Icons.abc, size: 20, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "- ${nutrient.x} ${S.of(context).requirement} ${nutrient.y}%",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Charts extends StatelessWidget {
  const Charts({super.key, required this.sections});
  final List<PieChartSectionData> sections;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 150, //MediaQuery.of(context).size.height / 2.4,
              width: 150, //MediaQuery.of(context).size.width,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 15, height: 15, color: Colors.green),
                    SizedBox(width: 5),
                    Text(
                      "Protein",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(width: 15, height: 15, color: Colors.orange),
                    SizedBox(width: 5),
                    Text("Fats", style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(width: 15, height: 15, color: Colors.blue),
                    SizedBox(width: 5),
                    Text(
                      "Carbohydrates",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BuldNutritionCaloriCard extends StatelessWidget {
  const BuldNutritionCaloriCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.grey[500]! : Colors.grey.shade800;
    final valuetextColor = isDarkMode ? Colors.white : Colors.black;
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle(context, S.of(context).caloricNeed, icon: null),
            const Divider(),
            Table(
              columnWidths: const {
                4: FlexColumnWidth(2),
                3: FlexColumnWidth(3),
              },
              children: [
                buildTableRowNutrition(
                  S.of(context).maintenance,
                  "${analysisResult.nutritionProfile.maintenance} kcal",
                  textColor,
                  valuetextColor,
                ),
                buildTableRowNutrition(
                  S.of(context).weightLoss,
                  "${analysisResult.nutritionProfile.weightLoss} kcal",
                  textColor,
                  valuetextColor,
                ),
                buildTableRowNutrition(
                  S.of(context).weightGain,
                  "${analysisResult.nutritionProfile.weightGain} kcal",
                  textColor,
                  valuetextColor,
                ),

                //_buildTableRow( 'Mineral İhtiyaçları', analysisResult.nutritionProfile.diet),
              ],
            ),
            const SizedBox(height: 16),
            //_buildMacronutrientSection(),
          ],
        ),
      ),
    );
  }
}

TableRow buildTableRowNutrition(
  String title,
  String value,
  Color textColor,
  Color valuetextColor,
) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          "$title:",
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(value, style: TextStyle(color: valuetextColor)),
      ),
    ],
  );
}
