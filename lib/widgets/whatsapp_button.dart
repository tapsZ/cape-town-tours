import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WhatsAppButton extends StatelessWidget {
  const WhatsAppButton({super.key});

  Future<void> _launchWhatsApp() async {
    final Uri url = Uri.parse('https://wa.me/27123456789?text=Hello! I am interested in booking a tour with Cape Best Tours.');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 30,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _launchWhatsApp,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF25D366),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.chat_bubble_outline,
              color: Colors.white,
              size: 30,
            ),
          )
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .scale(
            duration: 1000.ms,
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.1, 1.1),
            curve: Curves.easeInOut,
          ),
        ),
      ),
    ).animate().fadeIn(delay: 1.seconds);
  }
}
