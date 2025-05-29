import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/data.dart';
import 'package:dna_analyse/provider/medicine_provider.dart';
import 'package:dna_analyse/screens/view/medication/enhanced_add_medicine_screen.dart';
import 'package:dna_analyse/screens/view/medication/medicine_card_widget.dart';
import 'package:dna_analyse/screens/view/medication/medicine_overview_widget.dart';
import 'package:dna_analyse/services/loading_data.dart';
import 'package:dna_analyse/widgets/ai_button.dart';
import 'package:dna_analyse/widgets/buildSectionTitle_widget.dart';
import 'package:dna_analyse/widgets/mainWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicationView extends StatefulWidget {
  const MedicationView({super.key});

  @override
  State<MedicationView> createState() => _MedicationViewState();
}

class _MedicationViewState extends State<MedicationView> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late ScrollController scrollController;
  late Future<Map<String, dynamic>> futureAnalysis;

  bool showAppBarTitle = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      final isScrolled = scrollController.offset > 10;
      if (isScrolled != showAppBarTitle) {
        setState(() {
          showAppBarTitle = isScrolled;
        });
      }
    });

    futureAnalysis = JsonService.fetchDnaAnalysis();
  }

  @override
  void dispose() {
    _searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medicines = Provider.of<MedicineProvider>(context).medicines;
    // List<Medicine> filteredmedicines = medicines;
    final now = TimeOfDay.now();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    List<Medicine> forcedMedi =
        analysisResult.healthRisk.medicationRecommendations;

    final filteredMedicines =
        _searchQuery.isEmpty
            ? medicines
            : medicines
                .where(
                  (medicine) => medicine.name.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  ),
                )
                .toList();

    final filteredForcedMedi =
        _searchQuery.isEmpty
            ? forcedMedi
            : forcedMedi
                .where(
                  (medicine) => medicine.name.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  ),
                )
                .toList();

    Color _getStatusColor(Medicine medicine) {
      if (medicine.isTakenToday) return Colors.green;
      // if (medicine.time.hour < TimeOfDay.now().hour)
      if (medicine.time.hour < now.hour ||
          (medicine.time.hour == now.hour &&
              medicine.time.minute < now.minute)) {
        return Colors.red;
      }
      return Colors.orange;
    }

    String _getStatusText(Medicine medicine, BuildContext context) {
      if (medicine.isTakenToday) return S.of(context).taken;
      if (medicine.time.hour < now.hour ||
          (medicine.time.hour == now.hour &&
              medicine.time.minute < now.minute)) {
        return S.of(context).missed;
      }
      return S.of(context).upcoming;
    }

    //final List<String> measures = analysisResult.healthRisk.preventiveMeasures;
    // MedicationSorter(medications: forcedMedi),

    return Scaffold(
      drawer: Customdrawer(),
      appBar: medicineAppBar(context),
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
          final data = snapshot.data!;
          final analysesInformation =
              data['analysisResult']['analysesInformation'];
          final dynamic results = data['analysisResult'];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 8.0),
                      child: Text(
                        S.of(context).medicineTitle,
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    medicineOverview(
                      context,
                      filteredMedicines,
                      filteredForcedMedi,
                    ),
                    searchMedi(context, isDarkMode),
                    if (analysisResult
                        .healthRisk
                        .medicationRecommendations
                        .isNotEmpty) ...[
                      Text(
                        S.of(context).medicationsToBeUsed,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 190,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: forcedMedi.length,
                          itemBuilder: (context, index) {
                            return MedicineCard(
                              false,
                              statusColor: _getStatusColor(forcedMedi[index]),
                              statusText: _getStatusText(
                                forcedMedi[index],
                                context,
                              ),
                              medicine: forcedMedi[index],
                              onStatusChanged: (updatedMedicine) {
                                setState(() {
                                  forcedMedi[index] = updatedMedicine;
                                  Provider.of<MedicineProvider>(
                                    context,
                                    listen: false,
                                  ).updateMedicine(updatedMedicine);
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                    if (filteredMedicines.isNotEmpty) ...[
                      Text(
                        S.of(context).laterIdentifiedItems,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredMedicines.length,
                          itemBuilder:
                              (context, index) => MedicineCard(
                                true,
                                medicine: filteredMedicines[index],
                                statusColor: _getStatusColor(
                                  filteredMedicines[index],
                                ),
                                onStatusChanged: (updatedMedicine) {
                                  setState(() {
                                    filteredMedicines[index] = updatedMedicine;
                                    Provider.of<MedicineProvider>(
                                      context,
                                      listen: false,
                                    ).updateMedicine(updatedMedicine);
                                  });
                                },
                                statusText: _getStatusText(
                                  filteredMedicines[index],
                                  context,
                                ),
                              ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => EnhancedAddMedicineScreen()),
          );
        },
      ),
    );
  }

  AppBar medicineAppBar(BuildContext context) {
    return AppBar(
      title:
          scrollController.hasClients && scrollController.offset > 10
              ? Text(
                S.of(context).medicineTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              )
              : null,
      actions: [AiAssistant()],
    );
  }

  Padding searchMedi(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: S.of(context).searchMedicine,
          prefixIcon: Icon(Icons.search),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.grey.shade800 : Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.grey.shade800 : Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.white : Colors.black,
              width: 0.6,
            ),
          ),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
    );
  }
}
