import 'package:dna_analyse/utils/ai/chat_screen.dart';
import 'package:dna_analyse/utils/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final ColorScheme colorScheme;

  const MessageBubble({
    super.key,
    required this.message,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser)
            Container(
              margin: const EdgeInsets.only(right: 12),
              child: CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.2),
                child: Icon(
                  Mdi.robot,
                  //  Iconsax.cpu,
                  color: Colors.green.withOpacity(0.9),
                  size: 20,
                ),
              ),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:
                    message.isUser
                        ? green.withOpacity(0.5)
                        : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(17),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: message.isUser ? white : white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TypingIndicator extends StatelessWidget {
  final ColorScheme colorScheme;

  const TypingIndicator({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant,
            shape: BoxShape.circle,
          ),
          child: Text(
            'AI',
            // style: GoogleFonts.poppins(
            //   fontWeight: FontWeight.bold,
            //   color: colorScheme.primary,
            //   fontSize: 12,
            // ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Dot(color: colorScheme.primary),
              _Dot(color: colorScheme.primary),
              _Dot(color: colorScheme.primary),
            ],
          ),
        ),
      ],
    );
  }
}

class _Dot extends StatefulWidget {
  final Color color;

  const _Dot({required this.color});

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: 1000.ms)
      ..repeat(reverse: true);
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: white, shape: BoxShape.circle),
          ),
        );
      },
    );
  }
}

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  //final ColorScheme colorScheme;

  const InputField({
    super.key,
    required this.controller,
    required this.onSend,
    // required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Message...",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                  maxLines: 4,
                  minLines: 1,
                  style: GoogleFonts.poppins(),
                ),
              ),
              IconButton(
                icon: Icon(
                  Iconsax.send_1,
                  // color: colorScheme.primary,
                ),
                onPressed: onSend,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
