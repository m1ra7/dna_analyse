import 'package:dna_analyse/screens/view/medication/enhanced_add_medicine_screen.dart';
import 'package:dna_analyse/screens/medication_screen.dart';
import 'package:flutter/material.dart';
import 'package:dna_analyse/models/data.dart';
import 'package:dna_analyse/provider/medicine_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:dna_analyse/generated/l10n.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';

class MedicineDetailView extends StatelessWidget {
  final Medicine medicine;
  final bool isButtonActive;

  static const double _detailLabelWidth = 120.0;

  final Icon d = Icon(Mdi.pill);

  MedicineDetailView({
    super.key,
    this.isButtonActive = true, // Varsayılan değer olarak true
    required this.medicine,
  });

  void _editMedicine(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => EnhancedAddMedicineScreen(medicineToEdit: medicine),
      ),
    );
    // ).then((_) {
    //   if (mounted)
    //     Provider.of<MedicineProvider>(context, listen: false)
    //         .refreshMedicines();
    // });
  }

  void _deleteMedicine(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context).deleteMedicineTitle),
        content: Text(S.of(context).deleteMedicineConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              Provider.of<MedicineProvider>(context, listen: false)
                  .removeMedicine(medicine.id);
              Navigator.of(ctx)
                ..pop()
                ..pop();
            },
            child:
                Text(S.of(context).delete, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMd();
    //final timeFormat = TimeOfDayFormat.HH_colon_mm;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).basicInformation),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/pille.png",
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(width: 10),
                        Text(
                          medicine.name,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                    Divider(),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                        S.of(context).dosage, medicine.dosage, Mdi.pill),
                    _buildDetailRow(S.of(context).startDate,
                        dateFormat.format(medicine.startDate), Mdi.calendar),
                    if (medicine.endDate != null)
                      _buildDetailRow(
                        S.of(context).endDate,
                        dateFormat.format(medicine.endDate!),
                        Mdi.calendar,
                      ),
                    _buildDetailRow(
                        S.of(context).intakeTime,
                        medicine.time.format(context),
                        Icons.access_time_rounded),
                    if (medicine.notes?.isNotEmpty ?? false)
                      _buildDetailRow(
                          S.of(context).notes, medicine.notes!, Mdi.note),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            if (isButtonActive) ...[
              Align(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  child: ElevatedButton(
                    onPressed: () => _editMedicine(context),
                    child: Text(
                      S.of(context).edit,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Align(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () => _deleteMedicine(context),
                    child: Text(
                      S.of(context).delete,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.deepPurpleAccent[100]),
          SizedBox(
            width: 5,
          ),
          SizedBox(
            width: _detailLabelWidth,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
