import 'package:dna_analyse/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';

class MedicineAi extends StatefulWidget {
  final String? medicineName;

  const MedicineAi({super.key, this.medicineName});

  @override
  State<MedicineAi> createState() => _MedicineAiState();
}

class _MedicineAiState extends State<MedicineAi> {
  String? medicineInfo;
  String? medicineImageUrl;
  bool _isLoading = true;
  final String lottie = 'assets/animation/medicine_loarding.json';
  final String apiKey = "";

  @override
  void initState() {
    super.initState();
    if (widget.medicineName != null && widget.medicineName!.isNotEmpty) {
      _fetchMedicineInfo(widget.medicineName!);
    }
  }

  Future<void> _fetchMedicineInfo(String name) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: '', // API
      );
      // final prompt = "$name $metin";
      // final prompt =
      //     "$name what does it mean? What is it used for? What are its benefits? What are its side effects?";

      final prompt = "$name ilacı nedir? Ne işe yarar? Yan etkileri nelerdir?";
      final response = await model.generateContent([Content.text(prompt)]);

      setState(() {
        medicineInfo = response.text ?? "Bilgi alınamadı.";
        // Örnek bir resim URL'si kullanıldı. Gerçek projede API ile alınmalı.
        medicineImageUrl =
            "https://via.placeholder.com/150?text=${Uri.encodeComponent(name)}";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        medicineInfo = "Hata oluştu: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.medicineName ?? "İlaç";

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body:
          _isLoading
              ? Center(child: Card(child: Lottie.asset(lottie, width: 200)))
              : Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (medicineImageUrl != null)
                        Card(
                          child: Image.network(
                            medicineImageUrl!,
                            height: 200,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    Icon(Icons.broken_image, size: 100),
                          ),
                        ),
                      const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            medicineInfo ?? "Bilgi bulunamadı.",
                            style: TextStyle(fontSize: 16),
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

class MeasuresAi extends StatefulWidget {
  final String? measuresName;

  const MeasuresAi({super.key, this.measuresName});

  @override
  State<MeasuresAi> createState() => _MeasuresAiState();
}

class _MeasuresAiState extends State<MeasuresAi> {
  String? measuresInfo;
  String? measuresImageUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.measuresName != null && widget.measuresName!.isNotEmpty) {
      _fetchMedicineInfo(widget.measuresName!);
    }
  }

  Future<void> _fetchMedicineInfo(String name) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey, // API anahtarını buraya gir
      );
      // final prompt ="$name nedemek? Ne işe yarar? faydaliri nedir? Yan etkileri nelerdir?";
      final prompt =
          "$name what does it mean? What is it used for? What are its benefits? What are its side effects? türkce aciklama ingilizce yaz";
      // final prompt = "$name ${S.of(context).measuresAi}";

      final response = await model.generateContent([Content.text(prompt)]);

      setState(() {
        measuresInfo = response.text ?? "Bilgi alınamadı.";
        // Örnek bir resim URL'si kullanıldı. Gerçek projede API ile alınmalı.
        measuresImageUrl =
            "https://via.placeholder.com/150?text=${Uri.encodeComponent(name)}";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        measuresInfo = "Hata oluştu: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.measuresName ?? "İlaç";

    return Scaffold(
      appBar: AppBar(title: Text('$name Bilgisi')),
      body:
          _isLoading
              ? Center(
                child:
                    CircularProgressIndicator(), //Lottie.asset('assets/animation/medicine_loarding.json',width: 150,),
              )
              : Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (measuresImageUrl != null)
                        Card(
                          child: Image.network(
                            measuresImageUrl!,
                            height: 200,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    Icon(Icons.broken_image, size: 100),
                          ),
                        ),
                      const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            measuresInfo ?? "Bilgi bulunamadı.",
                            style: TextStyle(fontSize: 16),
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
