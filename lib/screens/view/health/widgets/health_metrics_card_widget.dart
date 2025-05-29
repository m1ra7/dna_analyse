import 'dart:ui';
import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/values.dart';
import 'package:dna_analyse/utils/appTheme.dart';
import 'package:dna_analyse/screens/view/%20dashboard/general_health_profile.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

class HealthMetricsCard extends StatefulWidget {
  const HealthMetricsCard({
    super.key,
    required this.metricKey,
    required this.metricValue,
    required this.index,
  });
  final int index;
  final List<String> metricKey;
  final int metricValue;

  @override
  State<HealthMetricsCard> createState() => _HealthMetricsCardState();
}

class _HealthMetricsCardState extends State<HealthMetricsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    Future.delayed(Duration(milliseconds: 100 * widget.index), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final index = widget.index;
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          color:
              isDarkMode(context)
                  ? const Color.fromARGB(255, 38, 37, 40)
                  : Colors.white,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: GestureDetector(
              onTap: () {
                debugPrint("${widget.metricKey} tıklandı");
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        keyHealthMetricsIcons[index],
                        size: 20,
                        color: keyHealthMetricsColors[index],
                      ),
                      SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          widget.metricKey[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: GFProgressBar(
                      percentage: widget.metricValue / 10,
                      circleWidth: 130,
                      backgroundColor:
                          isDarkMode(context)
                              ? gfProgressBarBackground
                              : gfProgressBarBackground.withValues(alpha: 0.25),
                      lineHeight: 9.5,
                      progressBarColor: keyHealthMetricsColors[index],
                      margin: const EdgeInsets.only(top: 10, bottom: 8),
                    ),
                  ),
                  Text(
                    "${S.of(context).risk}: ${widget.metricValue}/10",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
