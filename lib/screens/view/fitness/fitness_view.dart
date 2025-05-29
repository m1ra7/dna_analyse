import 'package:dna_analyse/screens/view/fitness/fitness_muscle_fiber_comosition.dart';
import 'package:dna_analyse/screens/view/fitness/fitness_rader_chart.dart';
import 'package:dna_analyse/utils/loading_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/data.dart';
import '../../../widgets/buildSectionTitle_widget.dart';

class FitnessView extends StatelessWidget {
  const FitnessView({super.key});

  //Internetten Retry özeligi
  Future<bool> _loadFitnessData() async {
    // Burada veri çekme işlemi yapılır (örneğin bir API çağrısı)
    await Future.delayed(const Duration(seconds: 3)); // Simülasyon
    return true; // throw Exception('Veri yüklenemedi!'); // Simüle edilen hata
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(title: Text("Fitness")),
      body: LoadingWrapper<bool>(
        future: _loadFitnessData,
        builder: (data) {
          return Scrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // artık veri yüklendi, bunları rahatça gösterebilirsin
                  const RaderChartFitness(),
                  const MuscleFiberComosition(),
                  _buildFitnessCard(context),
                  SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,

                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("data"),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFitnessCard(BuildContext context) {
    try {
      final profile = analysisResult.fitnessProfile;

      return Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionTitle(
                context,
                S.of(context).fitnessProfile,
                icon: null,
              ),
              const Divider(),
              _buildFitnessMetric(
                S.of(context).strength,
                profile.aptitude.strength.toString(),
                context,
              ),
              _buildFitnessMetric(
                S.of(context).power,
                profile.aptitude.power.toString(),
                context,
              ),
              _buildFitnessMetric(
                S.of(context).endurance,
                profile.aptitude.endurance.toString(),
                context,
              ),
              _buildFitnessMetric(
                S.of(context).flexibility,
                profile.aptitude.flexibility.toString(),
                context,
              ),
              const SizedBox(height: 16),
              _buildRecommendations(profile.recommendations, context),
            ],
          ),
        ),
      );
    } catch (e) {
      return const Text("Fitness verileri yüklenemedi.");
    }
  }

  Widget _buildFitnessMetric(
    String title,
    String? value,
    BuildContext context,
  ) {
    try {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            // const Icon(Icons.directions_run, color: Colors.white),
            //const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  Text(value ?? "Veri yok"),
                ],
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      return const Text("Bu metrik yüklenemedi.");
    }
  }

  Widget _buildRecommendations(
    List<String>? recommendations,
    BuildContext context,
  ) {
    try {
      if (recommendations == null || recommendations.isEmpty) {
        return const Text("Öneri bulunamadı.");
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).recommendations,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
          ),
          const SizedBox(height: 8),
          ...recommendations.map(
            (rec) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 15)),
                  Expanded(
                    child: Text(rec, style: const TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } catch (e) {
      return const Text("Öneriler yüklenemedi.");
    }
  }
}
