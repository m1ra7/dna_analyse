import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/screens/view/fitness/fitness_view.dart';
import 'package:dna_analyse/screens/view/health/health_view.dart';
import 'package:dna_analyse/screens/view/nutrition/nutrition_view.dart';
import 'package:dna_analyse/utils/tabBar/Geneticview_tab.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

GridView quickActions(BuildContext context, dynamic results) {
  return GridView.count(
    //Buttons olusturuyor
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    childAspectRatio: 1.5,
    //crossAxisSpacing: 15,
    //mainAxisSpacing: 15,
    children: [
      _buildActionCard(
        icon: FontAwesomeIcons.dna,
        title: S.of(context).genetics,
        color: Colors.blueAccent,
        page: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GeneticViewTab(results: results),
            ),
          );
        },
      ),
      _buildActionCard(
        icon: FontAwesomeIcons.heartPulse,
        title: S.of(context).health,
        color: Colors.red,
        page: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HealthIstatistic(results: results),
            ),
          );
        },
      ),
      _buildActionCard(
        icon: Icons.food_bank,
        title: S.of(context).nutrition,
        color: Colors.orange,
        page: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NutritionView()),
          );
        },
      ),
      _buildActionCard(
        icon: Icons.fitness_center,
        title: S.of(context).fitness,
        color: Colors.green,
        page: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FitnessView()),
          );
        },
      ),
    ],
  );
}

Widget _buildActionCard({
  required IconData icon,
  required String title,
  required Color color,
  required VoidCallback page,
}) {
  return GestureDetector(
    onTap: page,
    child: Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    ),
  );
}
