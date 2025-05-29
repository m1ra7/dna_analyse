import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/screens/view/genetic/widgets/dna_overview_infocard.dart';
import 'package:dna_analyse/widgets/buildSectionTitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DnaOverview extends StatelessWidget {
  const DnaOverview({super.key});
  final String dna = "assets/images/dnaImage.png";

  // Map<String, dynamic> dnaValue = {
  //   'Structure': "B",
  //   "Sugar\nphosphate\nbackbone": 18,
  //   'Angstrom': 23.3,
  // };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle(context, S.of(context).dnaOverview, icon: null),
            Divider(),
            Text(S.of(context).geneticTraitsDescription),
            SizedBox(height: 15),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.9,
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      dna,
                      width:
                          MediaQuery.of(context).size.width, //double.infinity,
                      height: MediaQuery.of(context).size.height / 2.9,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Mavi noktaların olduğu yerlere bilgi kartları
                  Positioned(
                    top: 0,
                    left: 100,
                    child: InfoCard(title: "B", description: 'Structure'),
                  ).animate().fadeIn().move(duration: 500.ms),
                  Positioned(
                    bottom: 60,
                    left: 6,
                    child: InfoCard(
                      title: "18",
                      description: 'Sugar\nphosphate\nbackbone',
                    ),
                  ).animate().fadeIn().move(duration: 500.ms),
                  Positioned(
                    bottom: 0,
                    left: 180,
                    child: const InfoCard(
                      title: '23.3',
                      description: 'Angstrom',
                    ),
                  ).animate().fadeIn().move(duration: 500.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
