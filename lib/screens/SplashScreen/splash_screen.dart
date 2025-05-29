import 'package:dna_analyse/main.dart';
import 'package:dna_analyse/screens/SplashScreen/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen2> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> _redirect() async {
    await Future.delayed(Duration(seconds: 3));
    final session = supabase.auth.currentSession;
    if (!mounted) return;
    if (session != null) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => IntroScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 120,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                      FontAwesomeIcons.dna,
                      size: 80,
                      //color: Colors.white; isDark ? Colors.grey[900] : Colors.deepPurple[50],
                    )
                    .animate()
                    .scale(duration: 800.ms)
                    .then(delay: 300.ms)
                    .shake(hz: 4, rotation: 0.2),
                const SizedBox(height: 20),
                Text(
                  'DNA Analiz',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    //color: Colors.white,
                  ),
                ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
                const SizedBox(height: 10),
                Text(
                  'DNA Analiz Uygulaması',
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        isDark
                            ? Colors.white.withOpacity(0.8)
                            : Colors.grey[900],
                  ),
                ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
