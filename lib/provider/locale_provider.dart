import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  late Locale current;
  //Locale current = const Locale("en");

  LocaleProvider() {
    // Cihazın varsayılan dilini al
    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
    current = _mapLocale(deviceLocale);
  }

  Locale _mapLocale(Locale deviceLocale) {
    switch (deviceLocale.languageCode) {
      case 'tr':
        return const Locale('tr');
      case 'en':
      default:
        return const Locale('en');
    }
  }

  void setTurkish() {
    current = const Locale('tr');
    notifyListeners();
  }

  void setEnglish() {
    current = const Locale('en');
    notifyListeners();
  }

  void setGerman() {
    current = const Locale('de');
    notifyListeners();
  }

  void setFrench() {
    current = const Locale('fr');
    notifyListeners();
  }
}
