import 'package:flutter/material.dart';
import 'package:dna_analyse/models/data.dart';

class MedicineProvider with ChangeNotifier {
  final List<Medicine> _medicines = [];

  List<Medicine> get medicines => _medicines;

  void addMedicine(Medicine medicine) {
    _medicines.add(medicine);
    notifyListeners();
  }

  void removeMedicine(String id) {
    _medicines.removeWhere((medicine) => medicine.id == id);
    notifyListeners();
  }

  void updateMedicine(Medicine updatedMedicine) {
    final index = _medicines.indexWhere((m) => m.id == updatedMedicine.id);

    if (index != -1) {
      _medicines[index] = updatedMedicine;
      notifyListeners();
    }
  }

  void refreshMedicines() {
    notifyListeners();
  }
}
