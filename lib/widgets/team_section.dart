import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cape_tours_cubit.dart';
import '../logic/cape_tours_state.dart';
import '../config/app_theme.dart';
import '../models/guide.dart';
import 'guide_card.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: isMobile ? 20 : 60),
      color: AppTheme.backgroundLight,
      child: Column(
        children: [
          Text(
            'Meet Our Expert Guides',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: isMobile ? 32 : 48,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Passion, Experience, and Local Knowledge',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              color: AppTheme.textLight,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 60),
          BlocBuilder<CapeToursCubit, CapeToursState>(
            builder: (context, state) {
              if (state is CapeToursLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              List<Guide> featuredGuides = [];
              if (state is CapeToursLoaded) {
                featuredGuides = state.guides.where((g) => g.isFeatured).toList();
              }

              if (featuredGuides.isEmpty) {
                return const SizedBox.shrink();
              }

              return cs.CarouselSlider(
                options: cs.CarouselOptions(
                  height: isMobile ? 550 : 600,
                  viewportFraction: isMobile ? 1.0 : 0.33,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  enableInfiniteScroll: featuredGuides.length > 3,
                ),
                items: featuredGuides.map((guide) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GuideCard(guide: guide),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: () => context.go('/guides'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.primaryBlue,
              side: const BorderSide(color: AppTheme.primaryBlue, width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'MEET ALL OUR GUIDES',
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward),
              ],
            ),
          ).animate().fadeIn(delay: 500.ms),
        ],
      ),
    );
  }
}


