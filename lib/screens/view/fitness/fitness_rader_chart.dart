import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/values.dart';
import 'package:dna_analyse/widgets/buildSectionTitle_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RaderChartFitness extends StatelessWidget {
  const RaderChartFitness({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.2,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionTitle(
                context,
                S.of(context).muscleComposition,
                icon: null,
              ),
              Divider(),
              SizedBox(height: 16),
              Expanded(
                child: RadarChart(
                  RadarChartData(
                    dataSets: [
                      RadarDataSet(
                        dataEntries: getFitnessValues(),
                        borderColor: Colors.blue,
                        fillColor: Colors.blueAccent.withValues(alpha: 0.3),
                        entryRadius: 4,
                      ),
                    ],
                    radarShape: RadarShape.polygon,
                    titlePositionPercentageOffset: 0.15,
                    tickCount: 3,
                    ticksTextStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    tickBorderData: BorderSide(color: Colors.blueGrey),
                    titleTextStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    getTitle: (index, meta) {
                      return RadarChartTitle(
                        text: getFitnessAttributeNames(context)[index],
                      );
                    },
                    radarBackgroundColor: const Color.fromARGB(255, 46, 43, 54),
                    gridBorderData: BorderSide(color: Colors.red),
                    borderData: FlBorderData(show: false),
                    radarBorderData: BorderSide(
                      color: Colors.blueAccent,
                      width: 2,
                    ),
                  ),
                  duration: Duration(
                    milliseconds: 500,
                  ), //swapAnimationDuration:
                  // Animation duration
                  curve:
                      Curves
                          .easeInOut, // Smooth animation// swapAnimationCurve:
                ),
              ),

              SizedBox(height: 15),
              Row(
                children: [
                  Container(color: Colors.blue, width: 10, height: 10),
                  const SizedBox(width: 5),
                  Text(
                    "Area",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(S.of(context).ClickForMoreDetails),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
