import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/screens/view/settings/password_change.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil", style: Theme.of(context).textTheme.displaySmall),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  title: Text(S.of(context).myPersonalInfo),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserProfile(),
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(S.of(context).changePassword),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePasswordPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  Future<List<dynamic>> _fetchProfile() async {
    final user = Supabase.instance.client.auth.currentUser;

    final response = await Supabase.instance.client
        .from('profil')
        .select()
        .eq('id', user!.id); // sadece bu kullanıcıya ait veri

    return response;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.grey[500]! : Colors.grey.shade800;
    final valuetextColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          S.of(context).myPersonalInfo,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Profil bulunamadı.'));
          }

          final profil =
              snapshot
                  .data![0]; // Liste döner, tek kullanıcı için ilk elemanı al

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).myInformation,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Table(
                          columnWidths: const {
                            4: FlexColumnWidth(2),
                            3: FlexColumnWidth(3),
                          },
                          children: [
                            buildTableRowUserData(
                              S.of(context).firstName,
                              profil['name'],
                              textColor,
                              valuetextColor,
                            ),
                            buildTableRowUserData(
                              S.of(context).lastName,
                              profil['surname'],
                              textColor,
                              valuetextColor,
                            ),
                            buildTableRowUserData(
                              S.of(context).birthDate,
                              profil['birthdate'].toString(),
                              textColor,
                              valuetextColor,
                            ),
                            buildTableRowUserData(
                              S.of(context).gender,
                              profil['gender'],
                              textColor,
                              valuetextColor,
                            ),
                            buildTableRowUserData(
                              S.of(context).bloodType,
                              profil['bloodtype'],
                              textColor,
                              valuetextColor,
                            ),
                            buildTableRowUserData(
                              S.of(context).height,
                              profil['height'].toString(),
                              textColor,
                              valuetextColor,
                            ),
                            buildTableRowUserData(
                              S.of(context).weight,
                              profil['weight'].toString(),
                              textColor,
                              valuetextColor,
                            ),
                            buildTableRowUserData(
                              S.of(context).allergies,
                              profil['allergies'],
                              textColor,
                              valuetextColor,
                            ),
                            buildTableRowUserData(
                              S.of(context).ethnicity,
                              profil['ethnicity'],
                              textColor,
                              valuetextColor,
                            ),
                            buildTableRowUserData(
                              S.of(context).currentMedications,
                              profil['currentmedications'],
                              textColor,
                              valuetextColor,
                            ),
                            buildTableRowUserData(
                              S.of(context).medicalHistory,
                              profil['medicalhistory'],
                              textColor,
                              valuetextColor,
                            ),
                            buildTableRowUserData(
                              S.of(context).familyHistory,
                              profil['familyhistory'],
                              textColor,
                              valuetextColor,
                            ),

                            buildTableRowUserData(
                              S.of(context).medicalHistory,
                              profil['medicalhistory'],
                              textColor,
                              valuetextColor,
                            ),
                            buildTableRowUserData(
                              "Created",
                              profil['created_at'],
                              textColor,
                              valuetextColor,
                            ),
                          ],
                        ),
                        //_buildMacronutrientSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  TableRow buildTableRowUserData(
    String title,
    String value,
    Color textColor,
    Color valuetextColor,
  ) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "$title:",
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(value, style: TextStyle(color: valuetextColor)),
        ),
      ],
    );
  }
}
