import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/widgets/buildSectionTitle_widget.dart';
import 'package:flutter/material.dart';

TableRow buildTableRowGenetic(
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

Widget buildGeneticTraitsCard(
  BuildContext context,
  Color textColor,
  Color valuetextColor,
  dynamic result,
) {
  return Card(
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionTitle(context, S.of(context).geneticTitle, icon: null),
          const Divider(),
          buildGeneticTraitsTable(result, context, textColor, valuetextColor),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}

Widget buildGeneticTraitsTable(
  dynamic result,
  BuildContext context,
  Color textColor,
  Color valuetextColor,
) {
  final userInformation = result['userInformation'];
  final geneticTraits = result["geneticTraits"];
  return Table(
    columnWidths: const {4: FlexColumnWidth(2), 3: FlexColumnWidth(3)},
    children: [
      buildTableRowGenetic(
        S.of(context).hairColor,
        userInformation["haircolor"],
        textColor,
        valuetextColor,
      ),
      buildTableRowGenetic(
        S.of(context).eyeColor,
        userInformation["eyecolor"],
        textColor,
        valuetextColor,
      ),

      buildTableRowGenetic(
        S.of(context).tastePerception,
        geneticTraits["tastePerception"],
        textColor,
        valuetextColor,
      ),
      buildTableRowGenetic(
        S.of(context).circadianRhythm,
        geneticTraits["circadianRhythm"],
        textColor,
        valuetextColor,
      ),
      buildTableRowGenetic(
        S.of(context).colorVision,
        geneticTraits["colorVision"],
        textColor,
        valuetextColor,
      ),
      buildTableRowGenetic(
        S.of(context).muscleStrength,
        geneticTraits["muscleStrength"],
        textColor,
        valuetextColor,
      ),
      buildTableRowGenetic(
        S.of(context).painPerception,
        geneticTraits["painPerception"],
        textColor,
        valuetextColor,
      ),
      buildTableRowGenetic(
        S.of(context).immuneSystemStrength,
        geneticTraits["immuneSystemStrength"],
        textColor,
        valuetextColor,
      ),
    ],
  );
}
