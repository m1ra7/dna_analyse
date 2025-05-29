import 'dart:io';
import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/provider/locale_provider.dart';
import 'package:dna_analyse/provider/theme_provider.dart';
import 'package:dna_analyse/screens/view/settings/changeIcon.dart';
import 'package:dna_analyse/screens/view/settings/password_change.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    String selectedLanguage =
        Provider.of<LocaleProvider>(context).current.toString();
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final langText = S.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          langText.settingsTitle,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Dark Mode Switch
          Card(
            child: SwitchListTile(
              activeColor: Colors.green,
              title: const Text('Dark Mode'),
              value: isDarkMode,
              onChanged: (value) {
                final newThemeMode = value ? ThemeMode.dark : ThemeMode.light;
                themeProvider.setThemeMode(newThemeMode);
              },
            ),
          ),
          if (Platform.isIOS)
            Card(
              child: ListTile(
                title: Text(langText.appIconChange),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Buraya şifre değiştirme sayfasına geçiş kodu eklersin
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangeIconPage(),
                    ),
                  );
                },
              ),
            ),
          Card(
            child: ListTile(
              title: Text(langText.languageSelection),
              trailing: DropdownButton<String>(
                borderRadius: BorderRadius.circular(10),
                value: selectedLanguage,
                underline: SizedBox.shrink(),
                items: [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text('English'),
                    onTap: () {
                      context.read<LocaleProvider>().setEnglish();
                    },
                  ),
                  DropdownMenuItem(
                    value: 'tr',
                    child: Text('Türkçe'),
                    onTap: () {
                      context.read<LocaleProvider>().setTurkish();
                    },
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedLanguage = value;
                    });
                  }
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(langText.changePassword),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Buraya şifre değiştirme sayfasına geçiş kodu eklersin
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
    );
  }
}
