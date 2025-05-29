// json_service.dart
import 'dart:convert';
import 'package:flutter/services.dart';

class JsonService {
  // 1. Yöntem: Assets klasöründen JSON okuma
  static Future<Map<String, dynamic>> loadFromAssets() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/api-response.json',
      );
      return json.decode(jsonString);
    } catch (e) {
      throw Exception('JSON dosyası yüklenemedi: $e');
    }
  }

  // 2. Yöntem: Doğrudan string olarak JSON
  //   static Map<String, dynamic> getJsonData() {
  //     const String jsonString = '''
  // {
  //   "analysesInformation": {
  //     "analysisName": "88Sample DNA Analysis with Known Markers",
  //     "sequenceLength": 1500,
  //     "analysisTypes": ["health_risk", "nutrition", "fitness", "genetic_traits"],
  //     "createdAt": "2024-01-15T10:30:00.000Z",
  //     "keyFindings": [
  //       "Your DNA profile has been analyzed across several health domains.",
  //       "Identified 0 potential health risk factors",
  //       "Detected 3 nutritional sensitivities",
  //       "Found 2 fitness-related genetic markers"
  //     ],
  //     "labName": "Genetics Lab",
  //     "referenceNumber": "DNA-2023-8876",
  //     "technologyUsed": "Next-Generation Sequencing"
  //   },
  //   "userInformation": {
  //     "tc": 123342443212,
  //     "name": "Mirac",
  //     "surname": "Suicmez",
  //     "age": 24,
  //     "gender": "erkek",
  //     "bloodType": "0 RH+",
  //     "height": "179",
  //     "weight": "73"
  //   },
  //   "keyHealthMetrics": {
  //     "cardiovascular": 6,
  //     "neurological": 3,
  //     "metabolisma": 4,
  //     "immuneSystem": 4
  //   }
  // }
  //     ''';

  //     return json.decode(jsonString);
  //   }

  // 3. Yöntem: API çağrısını simüle etme
  static Future<Map<String, dynamic>> fetchDnaAnalysis({int delay = 2}) async {
    // Network gecikmesi simülasyonu
    await Future.delayed(Duration(milliseconds: 500));

    // Başarı oranı %90 (hata simülasyonu için)
    // if (DateTime.now().millisecond % 10 == 0) {
    //   throw Exception('Network error: Unable to fetch DNA analysis');
    // }

    return loadFromAssets(); //getJsonData();
  }

  // 4. Belirli bölümleri getirme
  static Future<Map<String, dynamic>> getUserInfo() async {
    final data = await fetchDnaAnalysis();
    return data['userInformation'];
  }

  static Future<Map<String, dynamic>> getHealthMetrics() async {
    final data = await fetchDnaAnalysis();
    return data['keyHealthMetrics'];
  }

  static Future<List<dynamic>> getGeneticTraits() async {
    final data = await fetchDnaAnalysis();
    return data['geneticTraits']['traits'];
  }

  static Future<List<dynamic>> getMedications() async {
    final data = await fetchDnaAnalysis();
    return data['healthRisk']['medicationRecommendations'];
  }
}
