import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/values.dart';
import 'package:dna_analyse/utils/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

class BasicHealthMeasurements extends StatelessWidget {
  const BasicHealthMeasurements({
    super.key,
    required this.keyHealthMetrics,
    required this.keyHealthMetricsMap,
  });

  final List<String> keyHealthMetrics;
  final Map<String, dynamic> keyHealthMetricsMap;

  @override
  Widget build(BuildContext context) {
    // final Map<String, dynamic> riskValuesMap = valueHealthMetrics;
    final keyHealthMetricsList = keyHealthMetricsMap.entries.toList();

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).basicHealthMeasurements,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(keyHealthMetrics.length, (index) {
                final entry = keyHealthMetricsList[index];
                final keyHealthMetricsName = keyMetrics(context);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      debugPrint(keyHealthMetricsName[index]);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              keyHealthMetricsIcons[index %
                                  keyHealthMetricsIcons.length],
                              size: 20,
                              color:
                                  keyHealthMetricsColors[index %
                                      keyHealthMetricsColors.length],
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                keyHealthMetricsName[index],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        GFProgressBar(
                          percentage: entry.value / 10,
                          circleWidth: 130,
                          backgroundColor: const Color.fromARGB(
                            255,
                            50,
                            54,
                            70,
                          ),
                          lineHeight: 9.5,
                          progressBarColor:
                              keyHealthMetricsColors[index %
                                  keyHealthMetricsColors.length],
                          margin: const EdgeInsets.only(top: 10, bottom: 8),
                        ),
                        Text(
                          "${S.of(context).risk}: ${entry.value.toInt()}/10",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
