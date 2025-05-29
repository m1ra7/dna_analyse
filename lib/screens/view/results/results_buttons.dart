import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/screens/view/health/health_view.dart';
import 'package:dna_analyse/screens/view/health/recommendation_section_view.dart';
import 'package:dna_analyse/screens/view/summery/summery_view.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

class MediditationWidget extends StatelessWidget {
  const MediditationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person),
                Text(
                  "Focus & Mediditation ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            SizedBox(height: 10),
            Text("30 mins left"),
            SizedBox(height: 6),
            GFProgressBar(
              // width: MediaQuery.sizeOf(context).width / 2,
              progressBarColor: Colors.white,
              backgroundColor: Colors.grey.shade800,
              lineHeight: 10,
            ),
            SizedBox(height: 10),
            Text("Helps adress stress whether negative of positive."),
          ],
        ),
      ),
    );
  }
}

class SummeryButton extends StatelessWidget {
  const SummeryButton({super.key, required this.results});
  final dynamic results;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SummeryView(results: results),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text("Summery"),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}

class HealthIstatisticButton extends StatelessWidget {
  const HealthIstatisticButton({super.key, required this.results});
  final dynamic results;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HealthIstatistic(results: results),
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: Icon(Icons.analytics_rounded),
          trailing: Icon(Icons.chevron_right_rounded),
          title: Text(S.of(context).healthStatisticsReview),
        ),
      ),
    );
  }
}

class MedicationsMeasuresButton extends StatelessWidget {
  const MedicationsMeasuresButton({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MedicationsMeasures()),
        );
      },
      child: Card(
        child: ListTile(
          leading: Icon(Icons.medication_liquid_rounded),
          trailing: Icon(Icons.chevron_right_rounded),
          title: Text(S.of(context).medicationsAndImportanceReview),
        ),
      ),
    );
  }
}

Column recentActivity(BuildContext context) {
  return Column(
    children: [
      Text(
        S.of(context).recentActivity,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple.withOpacity(0.1),
                child: const Icon(Icons.assignment, color: Colors.deepPurple),
              ),
              title: const Text('New report available'),
              subtitle: const Text('2 days ago'),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    ],
  );
}
