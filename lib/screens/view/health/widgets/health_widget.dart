import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/values.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GeneticRiskCharts extends StatelessWidget {
  const GeneticRiskCharts({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      final data = geneticKeys(context);

      if (data.isEmpty) {
        return const Center(child: Text("Genetik risk verisi bulunamadı."));
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      S.of(context).geneticRiskFactors,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(),

                SizedBox(
                  height: 200,
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    title: ChartTitle(text: S.of(context).riskDistribution),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: [
                      ColumnSeries<ChartData, String>(
                        dataSource: data,
                        xValueMapper: (ChartData d, _) => d.x,
                        yValueMapper: (ChartData d, _) => d.y,
                        color: Colors.blue,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                ...data.map(
                  (risk) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          size: 20,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "${risk.x} riski: ${risk.y}%",
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
        ),
      );
    } catch (e, stack) {
      debugPrint("GeneticRiskCharts error: $e");
      debugPrintStack(stackTrace: stack);
      return const Center(
        child: Text(
          "Veri yüklenirken bir hata oluştu.",
          style: TextStyle(color: Colors.red),
        ),
      );
    }
  }
}

class HealthChart extends StatelessWidget {
  const HealthChart({
    super.key,
    required this.analysTyp,
    required this.analysData,
    required this.view,
  });
  final Function view;
  final List<String> analysTyp;
  final List<RadarEntry> analysData;

  @override
  Widget build(BuildContext context) {
    try {
      if (analysTyp.isEmpty || analysData.isEmpty) {
        return const Center(
          child: Text(
            "Sağlık analizi verileri bulunamadı.",
            style: TextStyle(color: Colors.red),
          ),
        );
      }

      return GestureDetector(
        onTap: () {
          debugPrint("HealthChart tapped");
          view();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.2,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).healthRiskAssessment,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: RadarChart(
                                RadarChartData(
                                  dataSets: [
                                    RadarDataSet(
                                      dataEntries: analysData,
                                      borderColor: Colors.red,
                                      fillColor: Colors.redAccent.withAlpha(80),
                                      entryRadius: 3,
                                    ),
                                  ],
                                  radarShape: RadarShape.polygon,
                                  titleTextStyle: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  titlePositionPercentageOffset: 0.15,
                                  tickCount: 3,
                                  tickBorderData: const BorderSide(
                                    color: Colors.blueGrey,
                                  ),
                                  getTitle: (index, _) {
                                    return RadarChartTitle(
                                      text: analysTyp[index],
                                    );
                                  },
                                  radarBackgroundColor: const Color.fromARGB(
                                    255,
                                    46,
                                    43,
                                    54,
                                  ),
                                  borderData: FlBorderData(show: false),
                                  radarBorderData: BorderSide(
                                    color: Colors.grey.shade700,
                                    width: 2,
                                  ),
                                ),
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(color: Colors.red, width: 10, height: 10),
                        const SizedBox(width: 5),
                        Text(
                          S.of(context).highRiskArea,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(S.of(context).ClickForMoreDetails),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } catch (e, stack) {
      debugPrint("HealthChart error: $e");
      debugPrintStack(stackTrace: stack);
      return const Center(
        child: Text(
          "Grafik yüklenirken hata oluştu.",
          style: TextStyle(color: Colors.red),
        ),
      );
    }
  }
}
