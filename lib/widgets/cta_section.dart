import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cape_tours_state.dart';
import '../logic/cape_tours_cubit.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return BlocBuilder<CapeToursCubit, CapeToursState>(
      builder: (context, state) {
        ImageProvider backgroundImage = const AssetImage('assets/images/portfolio/cape-town-city.webp');
        if (state is CapeToursLoaded && state.ctaSectionImage != null) {
          backgroundImage = NetworkImage(state.ctaSectionImage!.url);
        }

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue,
            image: DecorationImage(
              image: backgroundImage,
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
                'WE ARE PREPARING TO LAUNCH',
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
                'We\'re putting the finishing touches on our premium Cape Town experiences. Join our exclusive waitlist and be the first to know when we go live.',
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
                    text: 'LIKE THE IDEA',
                    icon: Icons.favorite,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Thank you! We\'re glad you\'re excited about Cape Best Tours!'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: AppTheme.accentOrange,
                        ),
                      );
                    },
                    isPrimary: true,
                  ),
                  _CTAButton(
                    text: 'GET NOTIFIED',
                    icon: Icons.notifications_active_outlined,
                    onPressed: () => launchUrl(Uri.parse('https://wa.me/27123456789?text=Hello! I\'d like to be notified when Cape Best Tours launches.')),
                    isPrimary: false,
                  ),
                ],
              ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.2, end: 0),
            ],
          ),
        ),
      ),
    );
      },
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

