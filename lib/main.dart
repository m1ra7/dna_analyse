import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/provider/locale_provider.dart';
import 'package:dna_analyse/provider/medicine_provider.dart';
import 'package:dna_analyse/provider/theme_provider.dart';
import 'package:dna_analyse/screens/dashboard_screen.dart';
import 'package:dna_analyse/screens/medication_screen.dart';
import 'package:dna_analyse/screens/results_screen.dart';
import 'package:dna_analyse/services/auth_gate.dart';
import 'package:dna_analyse/utils/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

const String supabaseUrl = 'https://nfncbchhndkftnejwxjz.supabase.co';
const String supabaseKey = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MedicineProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //Disable Rotate
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Consumer<LocaleProvider>(
      builder:
          (context, value, child) => MaterialApp(
            title: 'DNA Analyse',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: value.current,
            home: AuthGate(),
          ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedScreen = 0;
  final List<Widget> bodyScreen = [
    Dashboard(),
    ResultsView(),
    MedicationView(),
  ];

  void swichtScreen(value) {
    setState(() {
      _selectedScreen = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedScreen,
        children: [Dashboard(), ResultsView(), MedicationView()],
      ),
      bottomNavigationBar: salomonBottomBar(context),
    );
  }

  SalomonBottomBar salomonBottomBar(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: _selectedScreen,
      onTap: (index) => setState(() => _selectedScreen = index),
      items: [
        SalomonBottomBarItem(
          icon: Icon(Icons.home),
          title: Text(S.of(context).homescreenTitle),
          selectedColor: BottomColor.barItem1,
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.analytics_outlined),
          title: Text(S.of(context).analyseTitle),
          selectedColor: BottomColor.barItem2,
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.medication_rounded),
          title: Text(S.of(context).barItem3),
          selectedColor: BottomColor.barItem3,
        ),
      ],
    );
  }
}
