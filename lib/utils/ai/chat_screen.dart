import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/data.dart';

import 'package:dna_analyse/utils/ai/ui_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class GeminiChatScreen extends StatefulWidget {
  final Medicine? medicine;
  final String? initialMessage;
  const GeminiChatScreen({super.key, this.initialMessage, this.medicine});

  @override
  State<GeminiChatScreen> createState() => _GeminiChatScreenState();
}

class _GeminiChatScreenState extends State<GeminiChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  final String alDna = "assets/images/genetic_analytics_logo.png";

  @override
  void initState() {
    super.initState();
    _loadMessages();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialMessage != null && widget.initialMessage!.isNotEmpty) {
        _sendInitialMessage(widget.initialMessage!);
      }
      if (widget.medicine?.name != null && widget.medicine!.name.isNotEmpty) {
        _sendInitialMessage("${widget.medicine!.name} ne ilacidir?");
      }
    });
  }

  Future<void> _clearMessages() async {
    final shouldClear = await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Mesajları Temizle'),
            content: Text('Tüm sohbet geçmişi silinecek. Emin misiniz?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('İptal'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Temizle', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );

    if (shouldClear == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('chat_messages');

      setState(() {
        _messages.clear();
      });

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Mesaj geçmişi temizlendi'),
      //     duration: Duration(seconds: 2),
      //   ),
      // );
    }
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMessages = prefs.getStringList('chat_messages') ?? [];

    setState(() {
      _messages.addAll(
        savedMessages.map(
          (msg) => ChatMessage(
            text: msg.split('|||')[1],
            isUser: msg.split('|||')[0] == 'user',
            timestamp: DateTime.parse(msg.split('|||')[2]),
          ),
        ),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'chat_messages',
      _messages
          .map(
            (msg) =>
                '${msg.isUser ? 'user' : 'ai'}|||${msg.text}|||${msg.timestamp.toIso8601String()}',
          )
          .toList(),
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: 300.ms,
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendInitialMessage(String message) async {
    setState(() {
      _messages.add(
        ChatMessage(text: message, isUser: true, timestamp: DateTime.now()),
      );
      _isLoading = true;
    });

    _scrollToBottom();
    await Future.delayed(300.ms);

    try {
      final model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: '');

      final response = await model.generateContent([Content.text(message)]);

      setState(() {
        _messages.add(
          ChatMessage(
            text: response.text ?? "Yanıt alınamadı",
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: "Hata: ${e.toString()}",
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
        _isLoading = false;
      });
    }

    _scrollToBottom();
    await _saveMessages();
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty || _isLoading) return;

    final userMessage = _controller.text;
    _controller.clear();

    setState(() {
      _messages.add(
        ChatMessage(text: userMessage, isUser: true, timestamp: DateTime.now()),
      );
      _isLoading = true;
    });

    _scrollToBottom();
    await Future.delayed(300.ms);

    try {
      final model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: '');

      final response = await model.generateContent([Content.text(userMessage)]);

      setState(() {
        _messages.add(
          ChatMessage(
            text: response.text ?? "An unexpected error occurred",
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: "Error: ${e.toString()}",
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
        _isLoading = false;
      });
    }

    _scrollToBottom();
    await _saveMessages();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('AI (Gemini)'),
        centerTitle: false,
        actions: [
          IconButton(icon: Icon(Mdi.trashCan), onPressed: _clearMessages),
        ],
      ),
      body: Column(
        children: [
          if (_messages.isEmpty)
            Card(
              color: Colors.white.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image.asset(alDna, height: 130),
                    SizedBox(height: 10),
                    Text(
                      S.of(context).greetingsWelcome,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      S.of(context).greetingsPrompt,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  message: _messages[index],
                  colorScheme: colorScheme,
                ).animate().fadeIn(duration: 300.ms);
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TypingIndicator(colorScheme: colorScheme),
            ),
          InputField(
            controller: _controller,
            onSend: _sendMessage,
            // colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
