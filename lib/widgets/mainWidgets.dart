import 'package:dna_analyse/main.dart';
import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/screens/form/dna_analysis_form.dart';
import 'package:dna_analyse/screens/view/profil/user_profile.dart';
import 'package:dna_analyse/screens/view/settings/settings_view.dart';
import 'package:dna_analyse/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class Customdrawer extends StatelessWidget {
  const Customdrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    Future<void> logout() async {
      try {
        await authService.signOut();
        // Navigator.pop(context);
      } on AuthException catch (e) {
        print(e.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Error: ${e.message}",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent.shade200,
          ),
        );
      }
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()),
              );
            },
            child: DrawerHeader(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.account_circle, size: 80),
              ),
            ),
          ),
          // Menü Öğeleri
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(S.of(context).homescreenTitle),
            onTap: () {
              Navigator.pop(context); // Önce drawer'ı kapat
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
                (Route<dynamic> route) => false,
              );

              // Drawer'ı kapat
            },
          ),

          ListTile(
            leading: const Icon(Icons.person),
            title: Text("Profil"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.microscope),
            title: Text(S.of(context).testTitle),
            onTap: () {
              Navigator.of(context).pop();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DnaAnalysisForm()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(S.of(context).settingsTitle),
            onTap: () {
              Navigator.of(context).pop();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(S.of(context).logout),
            onTap: () {
              logout();
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.add),
          //   title: Text(S.of(context).homescreenTitle),
          //   onTap: () {
          //     Navigator.pop(context); // Önce drawer'ı kapat
          //     Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(builder: (context) => UserData()),
          //       (Route<dynamic> route) => false,
          //     );

          //     // Drawer'ı kapat
          //   },
          // ),
        ],
      ),
    );
  }
}
