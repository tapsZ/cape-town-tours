import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_theme.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Text(
            'READY TO EXPLORE CAPE TOWN?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            'Join us for an unforgettable journey through the most beautiful city in the world.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => launchUrl(Uri.parse('tel:+27836694518')),
                icon: const Icon(Icons.phone),
                label: const Text('CALL BRIAN'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
              ),
              const SizedBox(width: 20),
              OutlinedButton.icon(
                onPressed: () => launchUrl(Uri.parse('https://wa.me/27836694518')),
                icon: const Icon(Icons.chat),
                label: const Text('WHATSAPP'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  side: const BorderSide(color: AppTheme.primaryBlue, width: 2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
