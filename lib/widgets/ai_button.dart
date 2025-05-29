import 'package:dna_analyse/utils/ai/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';

class AiAssistant extends StatelessWidget {
  const AiAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Row(children: [Text("Al  "), Icon(Mdi.robot)]),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GeminiChatScreen()),
        );
      },
    );
  }
}
