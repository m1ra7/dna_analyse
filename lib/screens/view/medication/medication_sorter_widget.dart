import 'package:dna_analyse/models/data.dart';
import 'package:flutter/material.dart';

enum SortOption { byName, byDate, byTime, byActive, byTakenToday }

class MedicationSorter extends StatefulWidget {
  final List<Medicine> medications;

  MedicationSorter({required this.medications});

  @override
  _MedicationSorterState createState() => _MedicationSorterState();
}

class _MedicationSorterState extends State<MedicationSorter> {
  SortOption _selectedSortOption = SortOption.byName;

  void _sortMedications(SortOption option) {
    setState(() {
      _selectedSortOption = option;

      switch (option) {
        case SortOption.byName:
          widget.medications.sort((a, b) => a.name.compareTo(b.name));
          break;
        case SortOption.byDate:
          widget.medications.sort((a, b) => a.startDate.compareTo(b.startDate));
          break;
        case SortOption.byTime:
          widget.medications.sort((a, b) {
            if (a.time.hour != b.time.hour) {
              return a.time.hour.compareTo(b.time.hour);
            } else {
              return a.time.minute.compareTo(b.time.minute);
            }
          });
          break;
        case SortOption.byActive:
          widget.medications.sort(
            (a, b) => b.isActive.toString().compareTo(a.isActive.toString()),
          );
          break;
        case SortOption.byTakenToday:
          widget.medications.sort(
            (a, b) =>
                b.isTakenToday.toString().compareTo(a.isTakenToday.toString()),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<SortOption>(
          value: _selectedSortOption,
          onChanged: (value) => _sortMedications,
          items: [
            DropdownMenuItem(
              value: SortOption.byName,
              child: Text("İsmine göre sırala (A-Z)"),
            ),
            DropdownMenuItem(
              value: SortOption.byDate,
              child: Text("Başlangıç tarihine göre sırala"),
            ),
            DropdownMenuItem(
              value: SortOption.byTime,
              child: Text("Saatine göre sırala"),
            ),
            DropdownMenuItem(
              value: SortOption.byActive,
              child: Text("Aktif olanlar önce"),
            ),
            DropdownMenuItem(
              value: SortOption.byTakenToday,
              child: Text("Bugün alınacaklar önce"),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.medications.length,
            itemBuilder: (context, index) {
              final medicine = widget.medications[index];
              return ListTile(
                title: Text(medicine.name),
                subtitle: Text('Başlangıç: ${medicine.startDate.toString()}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
