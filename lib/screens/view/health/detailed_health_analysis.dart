import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/services/loading_data.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailedHealthRadar1 extends StatefulWidget {
  const DetailedHealthRadar1({super.key});

  @override
  State<DetailedHealthRadar1> createState() => _DetailedHealthRadar1State();
}

class _DetailedHealthRadar1State extends State<DetailedHealthRadar1> {
  late Future<Map<String, dynamic>> futureAnalysis;

  @override
  void initState() {
    super.initState();

    futureAnalysis = JsonService.fetchDnaAnalysis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          S.of(context).detailedRisks,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
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
          final results = data['analysisResult'];

          return SingleChildScrollView(
            child: DetailedHealthRiskAnalysis1(results: results),
          );
        },
      ),
    );
  }
}

Color _getRiskColor(String riskLevel) {
  if (riskLevel == 'High') {
    return Colors.red;
  } else if (riskLevel == 'Moderate') {
    return Colors.orange;
  } else if (riskLevel == 'Low') {
    return Colors.green;
  } else {
    return Colors.white;
  }
}

String _getRiskName(BuildContext context, String name) {
  if (name == "cardiovascularDisease") {
    return S.of(context).cardiovascularDisease;
  } else if (name == "alzheimersDisease") {
    return S.of(context).alzheimersDisease;
  } else if (name == "rheumatoidArthritis") {
    return S.of(context).rheumatoidArthritis;
  } else if (name == "type2Diabetes") {
    return S.of(context).type2Diabetes;
  } else if (name == "colorectalCancer") {
    return S.of(context).colorectalCancer;
  } else if (name == "bodyMassIndex") {
    return S.of(context).bodyMassIndex;
  } else if (name == "bloodPressure") {
    return S.of(context).bloodPressure;
  } else if (name == "cholesterol") {
    return S.of(context).cholesterol;
  } else if (name == "bloodSugar") {
    return S.of(context).bloodSugar;
  } else if (name == "physicalCondition") {
    return S.of(context).physicalCondition;
  } else if (name == "sleepQuality") {
    return S.of(context).sleepQuality;
  } else {
    return "";
  }
}

class DetailedHealthRiskAnalysis1 extends StatelessWidget {
  const DetailedHealthRiskAnalysis1({
    super.key,
    required this.results,
    // required conditions,
  });
  final dynamic results;
  // final conditions = analysisResult.healthRisk.healthConditions.rad1;

  @override
  Widget build(BuildContext context) {
    final dynamic conditions =
        results["healthRisk"]["healthConditions"]["rad1"];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: conditions.length,
      itemBuilder: (context, index) {
        final condition = conditions[index];
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
          child: _ModernRiskCard(condition: condition),
        );
      },
    );
  }

  Widget _buildRiskSummary() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Risk Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryItem('High', 2, Colors.red[300]!),
              _buildSummaryItem('Moderate', 2, Colors.orange[300]!),
              _buildSummaryItem('Low', 1, Colors.green[300]!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, int count, Color color) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: color,
          highlightColor: Colors.white,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Center(
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////
class DetailedHealthRadar2 extends StatelessWidget {
  const DetailedHealthRadar2({super.key, required this.results});
  final dynamic results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          S.of(context).detailedRisks,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: DetailedHealthRiskAnalysis2(results: results),
      ),
    );
  }
}

class DetailedHealthRiskAnalysis2 extends StatelessWidget {
  const DetailedHealthRiskAnalysis2({super.key, required this.results});
  final dynamic results;

  @override
  Widget build(BuildContext context) {
    final dynamic conditions =
        results["healthRisk"]["healthConditions"]["rad2"];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: conditions.length,
      itemBuilder: (context, index) {
        final condition = conditions[index];
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
          child: _ModernRiskCard(condition: condition),
        );
      },
    );
  }

  Widget _buildRiskSummary() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Risk Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryItem('High', 2, Colors.red[300]!),
              _buildSummaryItem('Moderate', 2, Colors.orange[300]!),
              _buildSummaryItem('Low', 1, Colors.green[300]!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, int count, Color color) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: color,
          highlightColor: Colors.white,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Center(
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _ModernRiskCard extends StatelessWidget {
  const _ModernRiskCard({required this.condition});
  final dynamic condition;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Color.fromARGB(255, 29, 27, 32) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getRiskName(context, condition["name"]),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getRiskColor(
                    condition["riskLevel"],
                  ).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  condition["riskLevel"],
                  style: TextStyle(
                    color: _getRiskColor(condition["riskLevel"]),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          SizedBox(height: 10),

          Text(
            "Risk: ${condition["riskLevel"]}",
            style: TextStyle(
              color: _getRiskColor(condition["riskLevel"]),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          Text(
            S.of(context).geneticMarkers,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                (condition["markers"] as List<dynamic>)
                    .map<Widget>(
                      (marker) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          marker.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    )
                    .toList(),
          ),

          SizedBox(height: 16),
          Text(
            S.of(context).recommendationsDetailed,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          ...(condition["recommendations"] as List<dynamic>)
              .map<Widget>(
                (rec) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 18),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(rec, style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
