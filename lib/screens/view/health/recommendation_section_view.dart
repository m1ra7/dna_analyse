import 'package:dna_analyse/generated/l10n.dart';
// import 'package:dna_analyse/models/data.dart';
import 'package:dna_analyse/screens/medication_screen.dart';
import 'package:dna_analyse/services/loading_data.dart';
import 'package:dna_analyse/utils/ai/medicine_measures_ai.dart';
import 'package:dna_analyse/utils/appTheme.dart';
import 'package:flutter/material.dart';

class MedicationsMeasures extends StatefulWidget {
  const MedicationsMeasures({super.key});

  @override
  State<MedicationsMeasures> createState() => _MedicationsMeasuresState();
}

class _MedicationsMeasuresState extends State<MedicationsMeasures> {
  final ScrollController scrollController = ScrollController();

  late Future<Map<String, dynamic>> futureAnalysis;

  @override
  void initState() {
    super.initState();
    futureAnalysis = JsonService.fetchDnaAnalysis();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).MedicationsAndMeasures)),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futureAnalysis,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 64, color: Colors.red),
                      SizedBox(height: 16),
                      Text(
                        'Hata: ${snapshot.error}',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          //List<Medicine>

          final data = snapshot.data!;
          final dynamic results = data['analysisResult'];
          final dynamic medication =
              data['analysisResult']['healthRisk']["medicationRecommendations"];
          final dynamic measures =
              data['analysisResult']['healthRisk']["preventiveMeasures"];

          return Scrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        S.of(context).MedicationAndMeasuresHelp,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getSizeWith(context),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor:
                            isDarkMode ? Colors.white70 : Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicationView(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.medication_liquid_rounded,
                            color: isDarkMode ? Colors.black : Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            S.of(context).TrackingMedication,
                            style: TextStyle(
                              color: isDarkMode ? Colors.black : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  if (medication != null) ...[
                    Text(
                      S.of(context).RecommendedMeds,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: medication.length,
                      itemBuilder: (context, index) {
                        final medi = medication[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        MedicineAi(medicineName: medi["name"]),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2,
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              // leading: Icon(Icons.medication, color: Colors.blue),
                              trailing: Icon(Icons.chevron_right_sharp),
                              title: Text(
                                medi["name"],
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                  if (measures != null) ...[
                    Text(
                      S.of(context).PreventiveMeasures,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: measures.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => MeasuresAi(
                                      measuresName: measures[index],
                                    ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2,
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              trailing: Icon(Icons.chevron_right_sharp),
                              title: Text(
                                measures[index],
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                  if (medication == null && measures == null)
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(
                        S.of(context).NoRecommendation,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
