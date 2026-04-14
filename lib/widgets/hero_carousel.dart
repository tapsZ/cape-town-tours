import 'package:flutter/material.dart' hide CarouselController;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_constants.dart';
import '../config/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cape_tours_state.dart';
import '../logic/cape_tours_cubit.dart';

class HeroCarousel extends StatelessWidget {
  final VoidCallback? onScrollToTours;

  const HeroCarousel({super.key, this.onScrollToTours});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return BlocBuilder<CapeToursCubit, CapeToursState>(
      builder: (context, state) {
        final List<Widget> items = [];

        if (state is CapeToursLoaded && state.heroImages.isNotEmpty) {
          items.addAll(state.heroImages.map((img) => _buildSlide(context, size, isMobile, NetworkImage(img.url))));
        } else {
          // Fallback
          items.addAll(AppConstants.heroImages.map((path) => _buildSlide(context, size, isMobile, AssetImage(path))));
        }

        return Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: isMobile ? 500 : 700,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 6),
                autoPlayAnimationDuration: const Duration(milliseconds: 1200),
                autoPlayCurve: Curves.easeInOutCubic,
              ),
              items: items,
            ),
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.accentOrange.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'LAUNCHING SOON',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: -0.2, end: 0),
                    const SizedBox(height: 24),
                    Text(
                      'WELCOME TO CAPE TOWN',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontSize: isMobile ? 40 : 72,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.0,
                            height: 1.1,
                          ),
                    )
                        .animate()
                        .fadeIn(duration: 800.ms)
                        .slideY(begin: 0.3, end: 0, curve: Curves.easeOutCubic),
                    const SizedBox(height: 16),
                    Text(
                      'Explore the beauty and culture of the Mother City',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: isMobile ? 18 : 28,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1.2,
                          ),
                    )
                        .animate(delay: 400.ms)
                        .fadeIn(duration: 800.ms)
                        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
                    const SizedBox(height: 48),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        _HeroButton(
                          text: 'VIEW TOURS',
                          onPressed: () => onScrollToTours?.call(),
                          isPrimary: true,
                        ),
                        _HeroButton(
                          text: 'CONTACT US',
                          onPressed: () => context.go('/contact'),
                          isPrimary: false,
                        ),
                      ],
                    ).animate(delay: 800.ms).fadeIn(duration: 800.ms).scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1, 1),
                          curve: Curves.elasticOut,
                        ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSlide(BuildContext context, Size size, bool isMobile, ImageProvider image) {
    return Stack(
      children: [
        Container(
          width: size.width,
          height: isMobile ? 500 : 700,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.2),
                Colors.black.withValues(alpha: 0.6),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const _HeroButton({
    required this.text,
    required this.onPressed,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppTheme.primaryBlue : Colors.white24,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width < 600 ? 24 : 32,
            vertical: MediaQuery.of(context).size.width < 600 ? 18 : 22,
          ),
          side: isPrimary ? null : const BorderSide(color: Colors.white, width: 2),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}

