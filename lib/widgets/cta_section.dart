import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/app_theme.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue,
        image: const DecorationImage(
          image: AssetImage('assets/images/portfolio/cape-town-city.webp'),
          fit: BoxFit.cover,
          opacity: 0.15,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 80 : 120,
        horizontal: 20,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              Text(
                'READY TO EXPLORE CAPE TOWN?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontSize: isMobile ? 32 : 56,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
              ).animate().fadeIn().scale(delay: 200.ms),
              const SizedBox(height: 24),
              Text(
                'Join our expert bucket-list tours and experience the Mother City like a local. Professional guides, private transport, and memories that last a lifetime.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: isMobile ? 16 : 20,
                  height: 1.6,
                  fontWeight: FontWeight.w300,
                ),
              ).animate(delay: 400.ms).fadeIn(),
              const SizedBox(height: 60),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _CTAButton(
                    text: 'BOOK VIA WHATSAPP',
                    icon: Icons.chat_bubble,
                    onPressed: () => launchUrl(Uri.parse('https://wa.me/27123456789?text=Hello! I\'m ready to book a tour.')),
                    isPrimary: true,
                  ),
                  _CTAButton(
                    text: 'CALL US NOW',
                    icon: Icons.phone_in_talk,
                    onPressed: () => launchUrl(Uri.parse('tel:+27123456789')),
                    isPrimary: false,
                  ),
                ],
              ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.2, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}

class _CTAButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isPrimary;

  const _CTAButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppTheme.accentOrange : Colors.white,
        foregroundColor: isPrimary ? Colors.white : AppTheme.primaryBlue,
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: isPrimary ? 10 : 0,
      ),
    );
  }
}

