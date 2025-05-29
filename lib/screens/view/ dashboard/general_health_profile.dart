import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/utils/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/types/gf_progress_type.dart';

const Color genralHealthProfileContainerDark = Color.fromARGB(255, 38, 37, 40);
const Color genralHealthProfileContainerWhite = Colors.blueGrey;
const Color genralHealthProfileContainerWhite2 = Color.fromARGB(
  255,
  139,
  214,
  243,
);

const Color genralHealthProfilehealthText = Color.fromARGB(255, 203, 204, 208);
const Color gfProgressBarBackground = Color.fromARGB(255, 50, 54, 70);

class GeneralHealthProfile extends StatelessWidget {
  final dynamic results;
  const GeneralHealthProfile(this.results, {super.key});
  @override
  Widget build(BuildContext context) {
    final score = 100 - (results['healthRisk']['riskScore'] * 100);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      width: size.width,
      height: size.height / 3.7,
      child: Container(
        decoration: BoxDecoration(
          color: genralHealthProfileContainerDark,

          borderRadius: BorderRadius.circular(
            8,
          ).copyWith(topRight: Radius.circular(68)),
          boxShadow: [
            BoxShadow(
              color:
                  isDarkMode
                      ? genralHealthProfileContainerDark
                      : genralHealthProfileContainerWhite,
              offset: Offset(1, 1),
              blurRadius: 1.0,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).generalProfile,
              style: TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.w700,
              ),
            ),
            Divider(color: Colors.white),
            Text(
              S.of(context).healthText,
              style: TextStyle(
                color: genralHealthProfilehealthText,
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    S.of(context).skorInfo,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: GFProgressBar(
                    percentage: score / 100,
                    radius: 88,
                    lineHeight: 20,
                    width: 100,
                    circleWidth: 19,
                    type: GFProgressType.circular,
                    progressHeadType: GFProgressHeadType.circular,
                    backgroundColor:
                        isDarkMode
                            ? gfProgressBarBackground
                            : Colors.white.withValues(alpha: 0.16),
                    progressBarColor: getProgressBarColor(score.toInt()),
                    child: Text(
                      score.toInt().toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 19,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
