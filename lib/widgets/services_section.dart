import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/app_theme.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: 20,
      ),
      color: AppTheme.backgroundLight,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'OUR SERVICES',
                    style: TextStyle(
                      color: AppTheme.primaryBlue,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontSize: isMobile ? 12 : 14,
                    ),
                  ).animate().fadeIn().slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 15),
                  Text(
                    'Why Choose Cape Best Tours?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: isMobile ? 32 : 48,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textDark,
                        ),
                  ).animate(delay: 200.ms).fadeIn(),
                  const SizedBox(height: 20),
                  Container(
                    width: 80,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.accentOrange,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ).animate(delay: 400.ms).fadeIn().scaleX(),
                ],
              ),
              const SizedBox(height: 80),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 900) {
                    return const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _ServiceCard(
                            icon: Icons.language,
                            title: 'Multi-Lingual Guides',
                            description:
                                'Our team is fluent in multiple international languages, ensuring a seamless experience for global travelers.',
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: _ServiceCard(
                            icon: Icons.verified_user_outlined,
                            title: 'Licensed Professionals',
                            description:
                                'All our guides are fully licensed and registered, providing expert knowledge of Cape Town\'s history and culture.',
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: _ServiceCard(
                            icon: Icons.explore_outlined,
                            title: 'Tailored Destinations',
                            description:
                                'From Table Mountain to the Cape Winelands, we offer private tours to any destination of your choice.',
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Column(
                      children: [
                        _ServiceCard(
                          icon: Icons.language,
                          title: 'Multi-Lingual Guides',
                          description:
                              'Our team is fluent in multiple international languages, ensuring a seamless experience for global travelers.',
                        ),
                        SizedBox(height: 30),
                        _ServiceCard(
                          icon: Icons.verified_user_outlined,
                          title: 'Licensed Professionals',
                          description:
                              'All our guides are fully licensed and registered, providing expert knowledge of Cape Town\'s history and culture.',
                        ),
                        SizedBox(height: 30),
                        _ServiceCard(
                          icon: Icons.explore_outlined,
                          title: 'Tailored Destinations',
                          description:
                              'From Table Mountain to the Cape Winelands, we offer private tours to any destination of your choice.',
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 25 : 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovered ? 0.1 : 0.05),
              blurRadius: _isHovered ? 30 : 10,
              offset: Offset(0, _isHovered ? 10 : 5),
            ),
          ],
          border: Border.all(
            color: _isHovered ? AppTheme.primaryBlue.withValues(alpha: 0.1) : Colors.transparent,
          ),
        ),
        child: Column(
          children: [
            AnimatedScale(
              scale: _isHovered ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  color: AppTheme.primaryBlue,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              widget.icon == Icons.language ? 'Why Us?' : widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                height: 1.6,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }
}

