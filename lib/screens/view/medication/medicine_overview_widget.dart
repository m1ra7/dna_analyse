import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/data.dart';
import 'package:dna_analyse/utils/appTheme.dart';
import 'package:flutter/material.dart';

Card medicineOverview(
  BuildContext context,
  List<Medicine> filteredMedicines,
  List<Medicine> filteredForcedMedi,
) {
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 10),
          child: Text(
            S.of(context).todaysOverview,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Replace your current GestureDetector widgets with these:
              GestureDetector(
                onTap: () => debugPrint("Total"),
                child: _buildTrackOverview(
                  filteredMedicines.length + filteredForcedMedi.length,
                  S.of(context).total,
                  Theme.of(context).brightness == Brightness.dark
                      ? white
                      : black,
                  context,
                ),
              ),
              GestureDetector(
                onTap: () => debugPrint("taken"),
                child: _buildTrackOverview(
                  filteredForcedMedi.where((m) => m.isTakenToday).length +
                      filteredMedicines.where((m) => m.isTakenToday).length,
                  S.of(context).taken,
                  Colors.greenAccent,
                  context,
                ),
              ),
              GestureDetector(
                onTap: () => debugPrint("upcoming"),
                child: _buildTrackOverview(
                  filteredForcedMedi
                          .where(
                            (m) =>
                                !m.isTakenToday &&
                                m.time.hour > TimeOfDay.now().hour,
                          )
                          .length +
                      filteredMedicines
                          .where(
                            (m) =>
                                !m.isTakenToday &&
                                m.time.hour > TimeOfDay.now().hour,
                          )
                          .length,
                  S.of(context).upcoming,
                  Colors.orange.shade300,
                  context,
                ),
              ),
              GestureDetector(
                onTap: () => debugPrint("missing"),
                child: _buildTrackOverview(
                  filteredForcedMedi
                          .where(
                            (m) =>
                                !m.isTakenToday &&
                                m.time.hour < TimeOfDay.now().hour,
                          )
                          .length +
                      filteredMedicines
                          .where(
                            (m) =>
                                !m.isTakenToday &&
                                m.time.hour < TimeOfDay.now().hour,
                          )
                          .length,
                  S.of(context).missed,
                  Colors.redAccent,
                  context,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Column _buildTrackOverview(
  int m,
  String type,
  Color color,
  BuildContext context,
) {
  return Column(
    children: [
      Text(
        m.toString(),
        style: TextStyle(
          fontSize: 26,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(type, style: TextStyle(fontSize: 18)),
    ],
  );
}
