import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../core/constants/app_constants.dart';
import '../config/app_theme.dart';
import 'package:flutter/material.dart' hide CarouselController;

class SocialProofSection extends StatelessWidget {
  const SocialProofSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: isMobile ? 20 : 60),
      color: Colors.white,
      child: Column(
        children: [
          // Trust Badges
          Wrap(
            spacing: isMobile ? 20 : 40,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _TrustBadge(icon: Icons.verified, label: 'TripAdvisor 2024'),
              _TrustBadge(icon: Icons.star_rate, label: '5.0 Google Rating'),
              _TrustBadge(icon: Icons.security, label: 'Secure Booking'),
            ],
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 60),

          // Stats Counter
          Wrap(
            spacing: isMobile ? 20 : 40,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _StatItem(value: '500+', label: 'Happy Tourists'),
              _StatItem(value: '14', label: 'Expert Guides'),
              _StatItem(value: '6', label: 'Curated Routes'),
              _StatItem(value: '20+', label: 'Years Experience'),
            ],
          ),
          const SizedBox(height: 80),

          // Testimonial Headline
          Text(
            'What Our Guests Say',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: isMobile ? 32 : 48,
                ),
          ),
          const SizedBox(height: 40),

          // Testimonial Carousel
          CarouselSlider(
            options: CarouselOptions(
              height: isMobile ? 320 : 300,
              viewportFraction: isMobile ? 1.0 : 0.45,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 8),
            ),
            items: AppConstants.testimonials.map((testimonial) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(5, (index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          )),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Text(
                            '"${testimonial.text}"',
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: AppTheme.textDark,
                              height: 1.5,
                            ),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppTheme.primaryBlue,
                              radius: 20,
                              child: Text(
                                testimonial.name[0],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  testimonial.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  testimonial.country,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textLight,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _TrustBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TrustBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey[400], size: 32),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: AppTheme.primaryBlue,
              letterSpacing: -2,
            ),
          ).animate().scale(delay: 400.ms, duration: 600.ms, curve: Curves.elasticOut),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppTheme.textLight,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
