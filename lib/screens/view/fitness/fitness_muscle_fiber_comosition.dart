import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/data.dart';
import 'package:dna_analyse/widgets/buildSectionTitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

class MuscleFiberComosition extends StatelessWidget {
  const MuscleFiberComosition({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                buildSectionTitle(
                  context,
                  S.of(context).muscleFiberComposition,
                  icon: null,
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).fastTwitch,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  "${analysisResult.fitnessProfile.muscleFiberComposition.fastTwitch} %",
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ],
            ),
            GFProgressBar(
              percentage:
                  analysisResult
                      .fitnessProfile
                      .muscleFiberComposition
                      .fastTwitch /
                  100,
              circleWidth: 130,
              backgroundColor: const Color.fromARGB(255, 50, 54, 70),
              lineHeight: 12,
              progressBarColor: Colors.blue,
              margin: const EdgeInsets.all(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).slowTwitch,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  "${analysisResult.fitnessProfile.muscleFiberComposition.slowTwich} %",
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ],
            ),
            GFProgressBar(
              percentage: 6 / 10,
              circleWidth: 130,
              backgroundColor: const Color.fromARGB(255, 50, 54, 70),
              lineHeight: 12,
              progressBarColor: Colors.blue,
              margin: const EdgeInsets.all(10),
            ),
          ],
        ),
      ),
    );
  }
}
