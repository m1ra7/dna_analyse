import 'package:dna_analyse/generated/l10n.dart';
import 'package:flutter/material.dart';

class AnalysisInformationCard extends StatelessWidget {
  const AnalysisInformationCard({super.key, required this.result});
  final dynamic result;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? const Color(0xFF9E9E9E) : Colors.black;
    final valuetextColor = isDarkMode ? Colors.white : Colors.grey[800];
    final analysisTypeTextColor = isDarkMode ? Colors.white : Colors.grey[900];

    return Column(
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Header
                ListTile(
                  title: Text(
                    S.of(context).DNAAnalysisReport,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    S.of(context).ComprehensiveGeneticResults,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: textColor),
                  ),
                ),

                const Divider(height: 1),

                _buildInfoTile(
                  context,
                  S.of(context).AnalysisName,
                  result["analysisName"],
                  textColor,
                  valuetextColor,
                ),
                _buildInfoTile(
                  context,
                  S.of(context).SequenceLength,
                  '${result["sequenceLength"]} ${S.of(context).BasePairs}',
                  textColor,
                  valuetextColor,
                ),
                _buildInfoTile(
                  context,
                  S.of(context).ReferenceNumber,
                  result["referenceNumber"],
                  textColor,
                  valuetextColor,
                ),
                _buildInfoTile(
                  context,
                  S.of(context).TechnologyUsed,
                  result["technologyUsed"],
                  textColor,
                  valuetextColor,
                ),
                _buildInfoTile(
                  context,
                  S.of(context).CreatedDate,
                  result["createdAt"],
                  //DateFormat('MMMM d, y').format(result["createdAt"]),
                  textColor,
                  valuetextColor,
                ),
                _buildInfoTile(
                  context,
                  S.of(context).LabName,
                  result["labName"],
                  textColor,
                  valuetextColor,
                ),

                // Analysis Types
                ListTile(
                  title: Text(
                    S.of(context).AnalysisTypes,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Wrap(
                      spacing: 9,
                      runSpacing: 9,
                      children:
                          (result["analysisTypes"] as List<dynamic>)
                              .map<Widget>(
                                (type) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getTypeColor(type).withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    type
                                        .toString()
                                        .replaceAll('_', ' ')
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: analysisTypeTextColor,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        KeyFindings(result: result),
      ],
    );
  }

  Widget _buildInfoTile(
    BuildContext context,
    String title,
    String value,
    Color titleColor,
    Color? valueColor,
  ) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: titleColor,
        ),
      ),
      subtitle: Text(value, style: TextStyle(color: valueColor)),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'health_risk':
        return Colors.red.withOpacity(0.7);
      case 'nutrition':
        return Colors.green[900]!;
      case 'fitness':
        return Colors.yellow[900]!;
      case 'genetic_traits':
        return Colors.purple[500]!;
      default:
        return Colors.blue[500]!;
    }
  }
}

class KeyFindings extends StatelessWidget {
  const KeyFindings({super.key, required this.result});
  final dynamic result;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          title: Text(
            S.of(context).KeyFindings,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              ...List<Widget>.from(
                (result["keyFindings"] as List<dynamic>).map(
                  (finding) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.circle, size: 8, color: Colors.blue),
                        const SizedBox(width: 8),
                        Expanded(child: Text(finding.toString())),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
