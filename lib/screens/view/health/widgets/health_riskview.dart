import 'dart:math';
import 'package:dna_analyse/utils/appTheme.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/types/gf_progress_type.dart';
import 'package:vector_math/vector_math.dart' as vm;
import 'package:dna_analyse/generated/l10n.dart';
import 'package:flutter/material.dart';

class HealthAssessment extends StatelessWidget {
  const HealthAssessment({super.key, required this.results});

  final dynamic results;
  @override
  Widget build(BuildContext context) {
    final double riskScore = results["healthRisk"]['riskScore'];
    final double score = riskScore * 100;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              S.of(context).healthAssessmentTitle,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              S.of(context).healthStatusBasedOnRisk,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Divider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100,
                  child: GFProgressBar(
                    percentage: 1 - riskScore,
                    radius: 80,
                    lineHeight: 20,
                    width: 90,
                    circleWidth: 19,
                    type: GFProgressType.circular,
                    progressHeadType: GFProgressHeadType.circular,
                    backgroundColor: Color.fromARGB(255, 50, 54, 70),
                    progressBarColor: getProgressBarColor(
                      (100 - score).toInt(),
                    ),
                    child: Text(
                      (score).toInt().toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 19,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: GFProgressBar(
                    percentage: riskScore,
                    radius: 80,
                    lineHeight: 20,
                    width: 90,
                    circleWidth: 19,
                    type: GFProgressType.circular,
                    progressHeadType: GFProgressHeadType.circular,
                    backgroundColor: Color.fromARGB(255, 50, 54, 70),
                    progressBarColor: getProgressBarColor((score).toInt()),
                    child: Text(
                      score.toInt().toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 19,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Align(
              child: Text(
                S
                    .of(context)
                    .healthAssessmentDescription(
                      score != null ? (score).toInt() : 0,
                      score != null ? (100 - score).toInt() : 0,
                    ),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///HealthDashBoard
class HealthDashboard extends StatefulWidget {
  const HealthDashboard({super.key, required this.healthRiskData});
  final dynamic healthRiskData;

  @override
  State<HealthDashboard> createState() => _HealthDashboardState();
}

class _HealthDashboardState extends State<HealthDashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _currentAngle = 0;
  bool _isExpanded = false;

  final List<String> recommendations = [
    "Günde 10.000 adım hedefleyin",
    "Akdeniz diyetine uygun beslenin",
    "Haftada 3 kez direnç egzersizi yapın",
    "Stres seviyenizi yönetmek için mindfulness uygulayın",
    "Günde 7-8 saat kaliteli uyku uyuyun",
    "Düzenli sağlık taramalarınızı yaptırın",
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _currentAngle = -pi / 2;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = theme.colorScheme;
    final double risk = widget.healthRiskData['riskScore'];
    final double healthyPercentage = 100 - risk * 100;
    final double atRiskPercentage = risk * 100;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors:
                        isDark
                            ? [
                              const Color.fromARGB(255, 29, 27, 32),
                              const Color.fromARGB(255, 29, 27, 32),
                            ] //Colors.grey[900]!, Colors.grey[850]!]
                            : [Colors.white, Colors.grey[50]!],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color:
                          isDark
                              ? Colors.black.withValues(alpha: 0.6)
                              : Colors.grey.withValues(alpha: 0.2),
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // CircleAvatar(
                              //   backgroundColor: Colors.blue.withValues(
                              //     alpha: 0.1,
                              //   ),
                              //   child: const Icon(
                              //     Icons.health_and_safety,
                              //     //color: Colors.blue,
                              //   ),
                              // ),
                              // const SizedBox(width: 10),
                              Text(
                                S.of(context).healthAssessmentTitle,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                _isExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: colors.primary,
                              ),
                            ],
                          ),
                          Divider(),
                          Text(
                            S.of(context).healthStatusBasedOnRisk,
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              fontSize: 15,
                              //fontWeight: FontWeight.w00,
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 190,
                                  height: 190,
                                  child: CustomPaint(
                                    painter: _HealthRadialPainter(
                                      healthyPercentage: healthyPercentage,
                                      atRiskPercentage: atRiskPercentage,
                                      currentAngle: _currentAngle,
                                      isDark: isDark,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${healthyPercentage.toInt()}',
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(height: 10),
                          buildHealthStatusIndicator(
                            healthyPercentage,
                            atRiskPercentage,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        S
                            .of(context)
                            .healthAssessmentDescription(
                              (healthyPercentage).toInt(),
                              (100 - healthyPercentage).toInt(),
                            ),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    if (_isExpanded) ...[
                      Divider(
                        height: 1,
                        color: colors.outline.withValues(alpha: 0.2),
                        indent: 24,
                        endIndent: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'OPTİMİZASYON ÖNERİLERİ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: colors.onSurface.withValues(alpha: 0.8),
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ...recommendations.map(
                              (rec) => _buildRecommendationItem(rec, colors),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildHealthStatusIndicator(
    double healthyPercentage,
    double atRiskPercentage,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIndicatorItem('Sağlıklı:', healthyPercentage, [
          Colors.green,
          Colors.green,
        ]),
        _buildIndicatorItem('Riskli:', atRiskPercentage, [
          Colors.redAccent,
          Colors.red,
        ]),
      ],
    );
  }

  Widget _buildIndicatorItem(String label, double value, List<Color> colors) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.grey.withValues(alpha: 0.2),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 80 * (value / 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                gradient: LinearGradient(colors: colors),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$label ${value.toInt()}%',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colors[0],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationItem(String text, ColorScheme colors) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? Colors.green : Colors.blue[600],
            ),
            child: const Icon(Icons.check, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: colors.onSurface.withValues(alpha: 0.9),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HealthRadialPainter extends CustomPainter {
  final double healthyPercentage;
  final double atRiskPercentage;
  final double currentAngle;
  final bool isDark;

  _HealthRadialPainter({
    required this.healthyPercentage,
    required this.atRiskPercentage,
    required this.currentAngle,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Arkaplan daire
    // final backgroundPaint = Paint()
    //   ..color = isDark ? const Color(0xFF1E1E2E) : Colors.grey[100]!
    //   ..style = PaintingStyle.fill;
    // canvas.drawCircle(center, radius, backgroundPaint);

    // Dış halka efekti
    final outerRingPaint =
        Paint()
          ..color = isDark ? const Color(0xFF2D2D3A) : Colors.grey[200]!
          ..style = PaintingStyle.stroke
          ..strokeWidth = 19;
    canvas.drawCircle(center, radius - 6, outerRingPaint);

    // Risk yüzdesi (animasyonlu)
    final riskSweepAngle = vm.radians(360 * (atRiskPercentage / 100));
    final riskGradient = SweepGradient(
      startAngle: currentAngle,
      endAngle: currentAngle + riskSweepAngle,
      colors: const [Color(0xFFFF4B2B), Color(0xFFFF416C)],
    );
    final riskPaint =
        Paint()
          ..shader = riskGradient.createShader(
            Rect.fromCircle(center: center, radius: radius),
          )
          ..style = PaintingStyle.stroke
          ..strokeWidth = 25
          ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 6),
      currentAngle,
      riskSweepAngle,
      false,
      riskPaint,
    );

    // Sağlıklı yüzdesi (animasyonlu)
    final healthySweepAngle = vm.radians(360 * (healthyPercentage / 100));
    final healthyGradient = SweepGradient(
      startAngle: currentAngle + riskSweepAngle,
      endAngle: currentAngle + riskSweepAngle + healthySweepAngle,
      colors: const [Color(0xFF4CAF50), Color(0xFF8BC34A)],
    );
    final healthyPaint =
        Paint()
          ..shader = healthyGradient.createShader(
            Rect.fromCircle(center: center, radius: radius),
          )
          ..style = PaintingStyle.stroke
          ..strokeWidth = 25
          ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 6),
      currentAngle + riskSweepAngle,
      healthySweepAngle,
      false,
      healthyPaint,
    );

    // İç daire (glass morphism efekti)
    final innerCirclePaint =
        Paint()
          ..color = isDark ? const Color(0x402D2D3A) : const Color(0x60FFFFFF)
          ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.6, innerCirclePaint);

    // İç daire kenarlık
    final innerBorderPaint =
        Paint()
          ..color =
              isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.05)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;
    canvas.drawCircle(center, radius * 0.6, innerBorderPaint);

    // Nokta efektleri
    _drawDottedCircle(
      canvas,
      center,
      radius - 20,
      36,
      isDark
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.black.withValues(alpha: 0.05),
    );
  }

  void _drawDottedCircle(
    Canvas canvas,
    Offset center,
    double radius,
    int dotsCount,
    Color color,
  ) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    for (int i = 0; i < dotsCount; i++) {
      final angle = 2 * pi * i / dotsCount;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      canvas.drawCircle(Offset(x, y), 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
