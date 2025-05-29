import 'package:dna_analyse/models/data.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/types/gf_progress_type.dart';

class SummeryHealthStatus extends StatelessWidget {
  final HealthRisk risk;
  final bool isDark;
  final double score = analysisResult.healthRisk.riskScore;

  SummeryHealthStatus({super.key, required this.risk, required this.isDark});

  Color getProgressBarColor(double score) {
    if (score > 70) return Colors.red;
    if (score > 40) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8,
        ).copyWith(topRight: const Radius.circular(68)),
      ),
      color:
          isDark
              ? const Color.fromARGB(255, 29, 27, 32)
              : const Color.fromARGB(255, 50, 54, 70),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sağlık Durumunuz",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              "Risk analizinize göre sağlık durumunuz",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade300),
            ),
            const SizedBox(height: 16),

            // Skor Göstergesi
            Row(
              children: [
                Text(
                  "Risk Skoru:",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "${(risk.riskScore * 100).toInt()}",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
            GFProgressBar(
              margin: EdgeInsets.only(left: 4, right: 4, top: 5, bottom: 5),
              percentage: score,
              radius: 80,
              lineHeight: 10,
              // width: 150,
              circleWidth: 19,
              type: GFProgressType.linear,
              progressHeadType: GFProgressHeadType.circular,
              backgroundColor: Color.fromARGB(255, 50, 54, 70),
              progressBarColor: getProgressBarColor((score).toDouble()),
            ),

            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),

            // Önerilen İlaçlar
            if (analysisResult
                .healthRisk
                .medicationRecommendations
                .isNotEmpty) ...[
              Text(
                "Önerilen İlaçlar:",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    analysisResult.healthRisk.medicationRecommendations
                        .map(
                          (medicine) => Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "${medicine.name} (${medicine.dosage})",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),

                              // Align(
                              //   alignment: Alignment.topLeft,
                              //   child: Text(
                              //     "    ${medicine.time.format(context)}",
                              //     style: TextStyle(
                              //       color: Colors.grey[400],
                              //       fontSize: 14,
                              //     ),
                              //   ),
                              // ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "    ${medicine.notes} ",
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(color: Colors.grey[400]),
                                ),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        )
                        .toList(),
              ),
              // Text(
              //   analysisResult.healthRisk.medicationRecommendations.join(
              //     ', ',
              //   ),
              //   style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              // ),
            ],
            const Divider(),
            const SizedBox(height: 16),

            // Önleyici Tedbirler
            if (analysisResult.healthRisk.preventiveMeasures.isNotEmpty) ...[
              Text(
                "Önleyici Tedbirler:",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ...risk.preventiveMeasures.map(
                (measure) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 8,
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              measure,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
