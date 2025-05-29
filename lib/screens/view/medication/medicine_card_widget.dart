import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/data.dart';
import 'package:dna_analyse/provider/medicine_provider.dart';
import 'package:dna_analyse/screens/view/medication/medicine_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicineCard extends StatefulWidget {
  final Medicine medicine;
  final Function(Medicine) onStatusChanged;
  final Color statusColor;
  final String statusText;
  final bool isActive;

  const MedicineCard(
    this.isActive, {
    super.key,
    required this.medicine,
    required this.onStatusChanged,
    required this.statusColor,
    required this.statusText,
  });

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => MedicineDetailView(
                    isButtonActive: widget.isActive, // Buton devre dışı
                    medicine: widget.medicine, // Medicine nesnesi
                  ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: Image.asset(
              //     "assets/images/Kapsul.png",
              //     width: 80,
              //     height: 80,
              //   ),
              // ),
              //SizedBox(height: 8),
              Text(
                widget.medicine.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                '${S.of(context).dosage}: ${widget.medicine.dosage}',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '${widget.medicine.startDate.day}.${widget.medicine.startDate.month}.${widget.medicine.startDate.year}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              Card(
                color: Colors.blueGrey,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    widget.medicine.time.format(context),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Add this to your card widget, maybe near the top:
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.statusColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.statusText,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    // In your GridView.builder itemBuilder, replace the IconButton with:
                    IconButton(
                      onPressed: () async {
                        final confirmed =
                            await showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    icon: Icon(Icons.check_circle),
                                    title: Text(
                                      S.of(context).confirmMedicineTaken,
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed:
                                            () => setState(() {
                                              widget.medicine.isTakenToday =
                                                  !widget.medicine.isTakenToday;
                                              widget.medicine.lastTaken =
                                                  DateTime.now();
                                              // Update in provider
                                              Provider.of<MedicineProvider>(
                                                context,
                                                listen: false,
                                              ).updateMedicine(widget.medicine);
                                              Navigator.of(context).pop();
                                            }),
                                        child: Text("Yes"),
                                      ),
                                      ElevatedButton(
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                        child: Text(S.of(context).cancel),
                                      ),
                                    ],
                                  ),
                            ) ??
                            false;
                      },
                      icon: Icon(
                        widget.medicine.isTakenToday
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color:
                            widget.medicine.isTakenToday
                                ? Colors.green
                                : Colors.grey,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
