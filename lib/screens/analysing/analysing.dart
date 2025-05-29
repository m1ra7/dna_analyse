import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:lottie/lottie.dart';

class Analysing extends StatefulWidget {
  final List<String> analysisTypes; // Multiple analysis types

  const Analysing({super.key, required this.analysisTypes});

  @override
  State<Analysing> createState() => _AnalysingState();
}

class _AnalysingState extends State<Analysing> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _progressController;
  final String lottieDna = "assets/animation/dna.json";

  String _currentStatus = '';
  double _progress = 0.0;

  final List<String> _analysisSteps = [];

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _generateAnalysisSteps();
    _startAnalysis();
  }

  void _generateAnalysisSteps() {
    _analysisSteps.clear();

    for (int i = 0; i < widget.analysisTypes.length; i++) {
      String analysisName = _getAnalysisTitle(widget.analysisTypes[i]);
      _analysisSteps.addAll([
        '$analysisName ${S.of(context).fetchingDnaData}',
        '$analysisName ${S.of(context).analyzingGeneticMarkers}',
        '$analysisName ${S.of(context).scanningPolymorphisms}',
        '$analysisName ${S.of(context).calculatingResults}',
      ]);
    }

    _analysisSteps.add(S.of(context).preparingAllReports);
    _analysisSteps.add(S.of(context).analysisCompleted);
  }

  void _startAnalysis() async {
    for (int i = 0; i < _analysisSteps.length; i++) {
      setState(() {
        _currentStatus = _analysisSteps[i];
      });

      // Progress animasyonu
      _progressController.reset();
      _progressController.forward();

      // Her adım için rastgele bekleme süresi (1-3 saniye)
      await Future.delayed(
        Duration(milliseconds: 1000 + Random().nextInt(2000)),
      );

      setState(() {
        _progress = (i + 1) / _analysisSteps.length;
      });
    }

    // Analiz tamamlandı, dashboard'a geç
    await Future.delayed(const Duration(milliseconds: 500));
    _navigateToDashboard();
  }

  void _navigateToDashboard() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
    // '/dashboard', arguments: {'analysisTypes': widget.analysisTypes, 'completed': true},);
  }

  String _getAnalysisTitle(String analysisTyp) {
    switch (analysisTyp) {
      case 'fitness':
        return S.of(context).fitnessDnaAnalysis;

      case 'health':
        return S.of(context).healthDnaAnalysis;

      case 'nutrition':
        return S.of(context).nutritionDnaAnalysis;

      case 'genetic':
        return S.of(context).geneticTraitsAnalysis;

      default:
        return S.of(context).dnaAnalysis;
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          if (!isDarkMode) ...[
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6C56F5).withValues(alpha: 0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6C56F5).withValues(alpha: 0.08),
                ),
              ),
            ),
          ],
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // DNA Helix Animation
                    SizedBox(
                      width: 300,
                      height: 200,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer rotating ring
                          // AnimatedBuilder(
                          //   animation: _rotationController,
                          //   builder: (context, child) {
                          //     return Transform.rotate(
                          //       angle: _rotationController.value * 2 * pi,
                          //       child: Container(
                          //         width: 120,
                          //         height: 120,
                          //         decoration: BoxDecoration(
                          //           shape: BoxShape.circle,
                          //           border: Border.all(
                          //             color: const Color(
                          //               0xFF4ECDC4,
                          //             ).withOpacity(0.3),
                          //             width: 2,
                          //           ),
                          //         ),
                          //         child: const Icon(
                          //           Icons.biotech,
                          //           size: 60,
                          //           color: Color(0xFF4ECDC4),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                          // // Inner pulsing circle
                          Lottie.asset(
                            lottieDna,
                            fit: BoxFit.cover,
                            delegates: LottieDelegates(
                              values: [
                                ValueDelegate.color(
                                  const ['**'], // tüm katmanlara uygular
                                  value:
                                      isDarkMode
                                          ? Colors.white
                                          : Colors.blueAccent, // istediğin renk
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Title
                    Text(
                      _getAnalysisTitle(""),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    // Subtitle
                    Text(
                      S.of(context).dnaDataAnalyzing,
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            isDarkMode
                                ? Colors.white.withOpacity(0.7)
                                : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 25),

                    // Progress Bar
                    Container(
                      width: double.infinity,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color:
                            isDarkMode
                                ? Colors.white.withOpacity(0.1)
                                : Colors.grey,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: _progress,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isDarkMode ? Color(0xFF4ECDC4) : Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Progress Percentage
                    Text(
                      '${(_progress * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Color(0xFF4ECDC4) : Colors.black,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Current Status
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 50,

                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          _currentStatus,
                          key: ValueKey(_currentStatus),
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                isDarkMode
                                    ? Colors.white.withOpacity(0.8)
                                    : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Analysis Steps Indicator
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: List.generate(_analysisSteps.length, (index) {
                    //     return Container(
                    //       margin: const EdgeInsets.symmetric(horizontal: 4),
                    //       width: 10,
                    //       height: 10,
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color:
                    //             index <= _currentStep
                    //                 ? const Color(0xFF4ECDC4)
                    //                 : Colors.white.withOpacity(0.3),
                    //       ),
                    //     );
                    //   }),
                    // ),
                    const SizedBox(height: 30),

                    // Info Text
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color:
                            isDarkMode
                                ? Colors.white.withOpacity(0.05)
                                : Colors.blue[500],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.white.withOpacity(0.7),
                            size: 27,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            S.of(context).analysisMayTakeTime,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(
                              color: Colors.white.withOpacity(0.7),
                            ),

                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
