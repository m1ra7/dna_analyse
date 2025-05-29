import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/screens/view/genetic/genetic_view.dart';
import 'package:dna_analyse/screens/view/genetic/genetic_traits_view.dart';
import 'package:flutter/material.dart';

class GeneticViewTab extends StatelessWidget {
  const GeneticViewTab({super.key, required this.results});
  final dynamic results;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Kaç sekme varsa o kadar olmalı
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).results,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          bottom: TabBar(
            indicatorColor: Colors.blueAccent,
            labelColor: Colors.blueAccent,
            tabs: [Tab(text: S.of(context).geneticTitle), Tab(text: "Traits")],
          ),
        ),
        body: TabBarView(
          children: [GeneticTraitsView(), GeneticTraitsScreen()],
        ),
      ),
    );
  }
}
