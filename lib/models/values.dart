import 'dart:math';
import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/data.dart';
import 'package:dna_analyse/screens/view/%20dashboard/health_stats_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//Dashboard, smallCardWidget keys
final List<Map<String, Object>> cardWidgetKey = [
  // {
  //   "title": "Genetik",
  //   "icon": FontAwesomeIcons.dna,
  //   "color": Colors.blueAccent,
  //   "image": "assets/images/dna.png",
  //   "currentValue": "98%",
  //   "unit": "match",
  //   "page": () {},
  //   "grafik": widgetCard(
  //     type: SplineSeries<ChartData, String>(
  //       dataSource: generateData('genetic').cast<ChartData>(),
  //       xValueMapper: (ChartData data, _) => data.x,
  //       yValueMapper: (ChartData data, _) => data.y,
  //       color: Colors.blueAccent,
  //       width: 3,
  //       markerSettings: const MarkerSettings(
  //         isVisible: false,
  //       ),
  //     ),
  //     data: generateData('step').cast<ChartData>(),
  //     color: Colors.blueAccent,
  //     isVisible: false,
  //     plotAreaBorderWidt: 0.0,
  //   ),
  // },
  {
    "title": "Pulse",
    "icon": FontAwesomeIcons.heartPulse,
    "color": Colors.red,
    "image": "assets/images/lined heart.png",
    "currentValue": 72,
    "unit": "bpm",
    "page": () {},
    "grafik": widgetCard(
      type: LineSeries<ChartData, String>(
        dataSource: generateData('step').cast<ChartData>(),
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        color: Colors.red,
        width: 2,
        markerSettings: const MarkerSettings(
          isVisible: false,
          shape: DataMarkerType.circle,
          borderWidth: 2,
          borderColor: Colors.red,
          color: Colors.white,
        ),
      ),
      //data: generateData('step').cast<ChartData>(),
      color: Colors.red,
      isVisible: false,
      plotAreaBorderWidt: 0.0,
    ),
  },
  {
    "title": "Calorie",
    "icon": Icons.food_bank,
    "color": Colors.orange,
    "image": "assets/images/dna.png",
    "currentValue": 1850,
    "unit": "kcal",
    "page": () {},
    "grafik": widgetCard(
      type: SplineSeries<ChartData, String>(
        dataSource: generateData('step').cast<ChartData>(),
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        color: Colors.orange,
        width: 3,
        markerSettings: const MarkerSettings(isVisible: false),
      ),
      //data: generateData('step').cast<ChartData>(),
      color: Colors.orange,
      isVisible: false,
      plotAreaBorderWidt: 0.0,
    ),
  },
  {
    "title": "Step",
    "icon": Icons.fitness_center,
    "color": Colors.amber,
    "image": "assets/images/dna.png",
    "currentValue": "8,742",
    "unit": "steps",
    "page": () {},
    "grafik": widgetCard(
      type: SplineSeries<ChartData, String>(
        dataSource: generateData('calorie').cast<ChartData>(),
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        color: Colors.teal,
        width: 2,
        markerSettings: const MarkerSettings(
          isVisible: false,
          shape: DataMarkerType.diamond,
          borderWidth: 2,
          borderColor: Colors.teal,
          color: Colors.white,
        ),
      ),
      //data: generateData('step').cast<ChartData>(),
      color: Colors.teal,
      isVisible: false,
      plotAreaBorderWidt: 0.0,
    ),
  },
  {
    "title": "Sleep",
    "icon": FontAwesomeIcons.bed,
    "color": Colors.purple,
    "image": "assets/images/dna.png",
    "currentValue": "7.5",
    "unit": "hours",
    "page": () {},
    "grafik": widgetCard(
      type: ColumnSeries<ChartData, String>(
        dataSource: generateData('step').cast<ChartData>(),
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        color: Colors.green,
        borderRadius: BorderRadius.circular(4),
        width: 0.6,
      ),
      /**/
      /*SplineAreaSeries<ChartData, String>(
        dataSource: generateData('step').cast<ChartData>(),
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        gradient: LinearGradient(
          colors: [Colors.blueAccent.withOpacity(0.5), Colors.blueAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderWidth: 2,
        borderColor: Colors.blueAccent,
      ),*/
      //data: generateData('step').cast<ChartData>(),
      color: Colors.purple,
      isVisible: false,
      plotAreaBorderWidt: 0.0,
    ),
  },
  {
    "title": "Sugar level",
    "icon": Icons.fitness_center,
    "color": Colors.deepPurple,
    "image": "assets/images/dna.png",
    "currentValue": "92",
    "unit": "mg/dL",
    "page": () {},
    "grafik": widgetCard(
      type: SplineSeries<ChartData, String>(
        dataSource: generateData('sugar').cast<ChartData>(),
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        color: Colors.yellow,
        width: 3,
        markerSettings: const MarkerSettings(isVisible: false),
      ),
      //data: generateData('step').cast<ChartData>(),
      isVisible: false,
      plotAreaBorderWidt: 0.0,
      color: Colors.yellow,
    ),
  },
];

//Value for cardWidgetKey in Dashboard (Blood,sleep, sugar, sleep keys)
List<ChartData> generateData(String metricType) {
  final random = Random();
  return List.generate(7, (index) {
    double value;
    switch (metricType) {
      case 'pulse':
        value = 60 + random.nextDouble() * 40; // 60-100 BPM
        break;
      case 'bloodPressure':
        value = 80 + random.nextDouble() * 60; // 80-140 mmHg
        break;
      case 'sleep':
        value = random.nextDouble() * 8; // 0-8 saat
        break;
      case 'step':
        value = 70 + random.nextDouble() * 100; // 70-130 mg/dL
        break;
      case 'sugar':
        value = 70 + random.nextDouble() * 60; // 70-130 mg/dL
        break;
      case 'calorie':
        value = 90 + random.nextDouble() * 60; // 70-130 mg/dL
        break;
      default:
        value = 0;
    }
    return ChartData('Gün ${index + 1}', value);
  });
}

class ChartHealthMetricCard {
  final String title;
  final IconData icon;
  final Color color;
  final String currentValue;
  final String unit;
  final Widget chart;

  ChartHealthMetricCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.currentValue,
    required this.unit,
    required this.chart,
  });
}

//Fitness############
List<RadarEntry> getFitnessValues() {
  return [
    RadarEntry(value: analysisResult.fitnessProfile.aptitude.power), // Power
    RadarEntry(
      value: analysisResult.fitnessProfile.aptitude.flexibility,
    ), // Flexibility
    RadarEntry(
      value: analysisResult.fitnessProfile.aptitude.strength,
    ), // Strength
    RadarEntry(
      value: analysisResult.fitnessProfile.aptitude.endurance,
    ), // Endurance
  ];
}

List<String> getFitnessAttributeNames(BuildContext context) {
  return [
    S.of(context).strength,
    S.of(context).flexibility,
    S.of(context).power,
    S.of(context).endurance,
  ];
}
//Health ############

// List<int> riskValue = [
//   analysisResult.keyHealthMetrics.cardiovascular,
//   analysisResult.keyHealthMetrics.neurological,
//   analysisResult.keyHealthMetrics.metabolisma,
//   analysisResult.keyHealthMetrics.immuneSystem,
// ];

List<ChartData> geneticKeys(BuildContext context) {
  return [
    ChartData(S.of(context).heartRisk, 35),
    ChartData(S.of(context).diabetesRisk, 28),
    ChartData(S.of(context).cancerRisk, 15),
    ChartData(S.of(context).obesityRisk, 10),
    ChartData(S.of(context).alzheimersRisk, 8),
  ];
}

List<String> keyMetrics(BuildContext context) => [
  S.of(context).kardiyovaskuler,
  S.of(context).norolojik,
  S.of(context).metabolizma,
  S.of(context).bagisiklik,
];

List<IconData> keyHealthMetricsIcons = [
  Icons.monitor_heart_rounded,
  FontAwesomeIcons.brain,
  FontAwesomeIcons.utensils,
  FontAwesomeIcons.shieldVirus,
];

List<String> getHealthRiskLabels(BuildContext context) {
  return [
    S.of(context).bodyMassIndex,
    S.of(context).bloodPressure,
    S.of(context).cholesterol,
    S.of(context).physicalCondition,
    S.of(context).bloodSugar,
    S.of(context).sleepQuality,
  ];
}

List<RadarEntry> getHealthRiskValues() {
  return [
    RadarEntry(value: 70), // BMI
    RadarEntry(value: 85), // Blood Pressure
    RadarEntry(value: 60), // Cholesterol
    RadarEntry(value: 90), // Fitness Level
    RadarEntry(value: 75), // Blood Sugar
    RadarEntry(value: 65), // Sleep Quality
  ];
}

List<String> getHealthRiskLabels2(BuildContext context) {
  return [
    S.of(context).cardiovascularDisease,
    S.of(context).alzheimersDisease,
    S.of(context).rheumatoidArthritis,
    S.of(context).type2Diabetes,
    S.of(context).colorectalCancer,
  ];
} // cardiovascular

List<RadarEntry> getHealthRiskValues2() {
  return [
    RadarEntry(value: 40), //  Cardovascular
    RadarEntry(value: 10), // Alzheimers
    RadarEntry(value: 20), // reumatoid arthritis
    RadarEntry(value: 13), // Type 2 Diabetes
    RadarEntry(value: 11), //Colorectal Cancer
  ];
}

CircularProgressIndicator buildRiskScoreIndicator(double score) {
  Color getColor() {
    if (score > 0.7) return Colors.red;
    if (score > 0.4) return Colors.orange;
    return Colors.green;
  }

  return CircularProgressIndicator(
    value: score,
    backgroundColor: getColor().withValues(alpha: 0.15),
    color: getColor(),
    strokeWidth: 10,
  );
}

//Nutrition ##########

List<Map<String, dynamic>> getNutrientsWithValues(
  AnalysisResult nutritionAnalysisResult,
) {
  List<String> vitamins = nutritionAnalysisResult.nutritionProfile.vitaminNeeds
      .split(", ");
  List<String> minerals = nutritionAnalysisResult.nutritionProfile.mineralNeeds
      .split(", ");

  List<Map<String, dynamic>> nutrients = [];

  for (int i = 0; i < vitamins.length; i++) {
    nutrients.add({"name": vitamins[i], "value": (i + 1) * 10});
  }
  for (int i = 0; i < minerals.length; i++) {
    nutrients.add({"name": minerals[i], "value": (i + 1) * 12});
  }

  return nutrients;
}

Color getColorForMacronutrient(String macronutrient) {
  switch (macronutrient) {
    case "Carbohydrates":
      return Colors.blue;
    case "Protein":
      return Colors.green;
    case "Fats":
      return Colors.orange;
    default:
      return Colors.grey;
  }
}

class ChartData {
  final String x;
  final double y;
  final Color? color;

  ChartData(this.x, this.y, [this.color]);
}
