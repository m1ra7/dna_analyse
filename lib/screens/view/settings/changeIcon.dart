import 'package:another_flushbar/flushbar.dart';
import 'package:dna_analyse/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dynamic_icon_plus/flutter_dynamic_icon_plus.dart';

class ChangeIconPage extends StatefulWidget {
  const ChangeIconPage({super.key});

  @override
  State<ChangeIconPage> createState() => _ChangeIconPageState();
}

class _ChangeIconPageState extends State<ChangeIconPage> {
  List<String> icons = [
    "iconRedRetro",
    "iconRedTwo",
    "icon3",
    "icon4",
    "icon5",
    "icon6",
    "icon7",
  ];

  Future<void> _changeIcon(String iconName) async {
    try {
      final bool supportsAlternateIcons =
          await FlutterDynamicIconPlus.supportsAlternateIcons;
      if (supportsAlternateIcons) {
        await FlutterDynamicIconPlus.setAlternateIconName(iconName: iconName);
        print("App icon change successful");
        return;
      }
    } on PlatformException catch (e) {
      debugPrint('Error: ${e.message}');
      if (mounted) {
        Flushbar(
          message: e.message,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.redAccent.shade200,
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(5),
        ).show(context);
      }
      print("Failed to change app icon");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          S.of(context).appIconChange,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 8.0),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       "Logos:",
            //       style: Theme.of(context).textTheme.headlineSmall,
            //       textAlign: TextAlign.left,
            //     ),
            //   ),
            // ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(icons.length, (index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 10,
                          ),
                          child: InkWell(
                            onTap: () => _changeIcon(icons[index]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    'assets/AppIcon/${icons[index]}.jpg',
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  icons[index],
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (index != icons.length - 1)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Divider(),
                          ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
