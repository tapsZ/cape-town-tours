import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/app_theme.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBlue,
      body: Stack(
        children: [
          // Subtle background pattern or image
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/portfolio/cape-town-city.webp',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.handyman_outlined,
                      color: AppTheme.accentOrange,
                      size: 64,
                    ),
                  ).animate().fadeIn().scale(delay: 200.ms),
                  const SizedBox(height: 40),
                  Text(
                    'WE\'LL BE BACK SHORTLY',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                        ),
                  ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 16),
                  Text(
                    'We are performing some scheduled maintenance to improve your experience.\nThank you for your patience.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 18,
                      height: 1.6,
                    ),
                  ).animate(delay: 600.ms).fadeIn(),
                  const SizedBox(height: 60),
                  // Premium border button
                  OutlinedButton(
                    onPressed: () {
                      // Maybe a "Refresh" pulse?
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white24),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('CHECK AGAIN LATER', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.bold)),
                  ).animate(delay: 800.ms).fadeIn().scale(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
