import 'package:dna_analyse/main.dart';
import 'package:dna_analyse/screens/SplashScreen/intro_screen.dart';
import 'package:dna_analyse/screens/auth/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        // Supabase session durumunu kontrol edelim
        final session = snapshot.hasData ? snapshot.data?.session : null;
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Eğer bağlantı bekliyorsa, Splash gösterelim
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (session != null) {
          // Eğer oturum varsa, kullanıcıyı HomePage'e yönlendiriyoruz
          return MyHomePage();
        } else {
          // Eğer oturum yoksa, IntroScreen'e yönlendiriyoruz
          return IntroScreen();
        }
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
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
