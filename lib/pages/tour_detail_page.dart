import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../data/tour_data.dart';
import '../models/tour.dart';
import '../config/app_theme.dart';
import '../core/widgets/nav_bar.dart';
import '../core/widgets/footer.dart';
import '../widgets/tour_card.dart';
import '../widgets/whatsapp_button.dart';

class TourDetailPage extends StatelessWidget {
  final String slug;
  const TourDetailPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final tour = TourData.tours.firstWhere(
      (t) => t.slug == slug,
      orElse: () => TourData.tours.first,
    );

    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const NavBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _TourHero(tour: tour),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 60,
                    horizontal: isMobile ? 20 : 60,
                  ),
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _MainContent(tour: tour, isMobile: isMobile),
                          const SizedBox(height: 80),
                          _GallerySection(tour: tour),
                          const SizedBox(height: 80),
                          _TestimonialsSection(tourSlug: tour.slug),
                          const SizedBox(height: 80),
                          _RelatedToursSection(currentTourSlug: tour.slug),
                        ],
                      ),
                    ),
                  ),
                ),
                const Footer(),
              ],
            ),
          ),
          const WhatsAppButton(),
        ],
      ),
    );
  }
}

class _TourHero extends StatelessWidget {
  final Tour tour;
  const _TourHero({required this.tour});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Hero(
          tag: 'tour-${tour.id}',
          child: Image.asset(
            tour.imagePath,
            width: double.infinity,
            height: size.height * 0.7,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          height: size.height * 0.7,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 0.7),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.accentOrange,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    tour.category.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ).animate().fadeIn().scale(),
                const SizedBox(height: 20),
                Text(
                  tour.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontSize: size.width < 600 ? 36 : 64,
                        fontWeight: FontWeight.w900,
                      ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      '${tour.rating} (${tour.reviewCount} Reviews)',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 400.ms),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MainContent extends StatelessWidget {
  final Tour tour;
  final bool isMobile;
  const _MainContent({required this.tour, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Overview(tour: tour),
          const SizedBox(height: 40),
          _BookingCard(tour: tour),
          const SizedBox(height: 40),
          _HighlightsIncluded(tour: tour),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Overview(tour: tour),
              const SizedBox(height: 60),
              _HighlightsIncluded(tour: tour),
            ],
          ),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 1,
          child: _StickySidebar(tour: tour),
        ),
      ],
    );
  }
}

class _Overview extends StatelessWidget {
  final Tour tour;
  const _Overview({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'Overview'),
        const SizedBox(height: 20),
        Text(
          tour.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.8,
                color: Colors.grey[700],
                fontSize: 18,
              ),
        ),
      ],
    );
  }
}

class _HighlightsIncluded extends StatelessWidget {
  final Tour tour;
  const _HighlightsIncluded({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'Highlights'),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: tour.highlights.map((h) => _Tag(label: h)).toList(),
        ),
        const SizedBox(height: 60),
        LayoutBuilder(
          builder: (context, constraints) {
            final isMobileLayout = constraints.maxWidth < 700;
            if (isMobileLayout) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _IconList(
                    title: 'What\'s Included',
                    items: tour.included,
                    icon: Icons.check_circle_outline,
                    iconColor: Colors.green,
                  ),
                  const SizedBox(height: 40),
                  _IconList(
                    title: 'What to Bring',
                    items: tour.whatToBring,
                    icon: Icons.info_outline,
                    iconColor: AppTheme.accentOrange,
                  ),
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _IconList(
                    title: 'What\'s Included',
                    items: tour.included,
                    icon: Icons.check_circle_outline,
                    iconColor: Colors.green,
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: _IconList(
                    title: 'What to Bring',
                    items: tour.whatToBring,
                    icon: Icons.info_outline,
                    iconColor: AppTheme.accentOrange,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _StickySidebar extends StatelessWidget {
  final Tour tour;
  const _StickySidebar({required this.tour});

  @override
  Widget build(BuildContext context) {
    return _BookingCard(tour: tour);
  }
}

class _BookingCard extends StatelessWidget {
  final Tour tour;
  const _BookingCard({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FROM',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppTheme.textLight,
              letterSpacing: 1.5,
            ),
          ),
          Text(
            'R${tour.priceFrom.toInt()}',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: AppTheme.primaryBlue,
            ),
          ),
          const SizedBox(height: 30),
          _DetailRow(icon: Icons.timer_outlined, label: tour.duration),
          const SizedBox(height: 15),
          _DetailRow(icon: Icons.people_outline, label: tour.groupSize),
          const SizedBox(height: 15),
          _DetailRow(icon: Icons.language_outlined, label: 'English / German'),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => launchUrl(Uri.parse(
                'https://wa.me/27123456789?text=Hello! I would like to book the ${tour.title} tour.')),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 65),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              'BOOK VIA WHATSAPP',
              style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Fast & Secure Booking',
              style: TextStyle(fontSize: 12, color: AppTheme.textLight),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DetailRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryBlue, size: 24),
        const SizedBox(width: 15),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.textDark,
          ),
        ),
      ],
    );
  }
}

class _GallerySection extends StatelessWidget {
  final Tour tour;
  const _GallerySection({required this.tour});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'Photo Gallery'),
        const SizedBox(height: 30),
        CarouselSlider(
          options: CarouselOptions(
            height: isMobile ? 300 : 500,
            viewportFraction: isMobile ? 1.0 : 0.8,
            enlargeCenterPage: true,
            autoPlay: true,
          ),
          items: tour.galleryImages.map((img) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                img,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _TestimonialsSection extends StatelessWidget {
  final String tourSlug;
  const _TestimonialsSection({required this.tourSlug});

  @override
  Widget build(BuildContext context) {
    final testimonials =
        TourData.testimonials.where((t) => t.tourSlug == tourSlug).toList();

    if (testimonials.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'Guest Reviews'),
        const SizedBox(height: 30),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: testimonials.length,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final t = testimonials[index];
            return Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                        5, (i) => const Icon(Icons.star, color: Colors.amber, size: 16)),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '"${t.text}"',
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '— ${t.name}, ${t.country}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _RelatedToursSection extends StatelessWidget {
  final String currentTourSlug;
  const _RelatedToursSection({required this.currentTourSlug});

  @override
  Widget build(BuildContext context) {
    final relatedTours = TourData.tours
        .where((t) => t.slug != currentTourSlug)
        .take(3)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'You Might Also Like'),
        const SizedBox(height: 30),
        LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 800;
            if (isMobile) {
              return Column(
                children: relatedTours
                    .map((t) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TourCard(tour: t),
                        ))
                    .toList(),
              );
            }
            return Row(
              children: relatedTours
                  .map((t) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TourCard(tour: t),
                        ),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: AppTheme.textDark,
        letterSpacing: -0.5,
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primaryBlue.withValues(alpha: 0.1)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppTheme.primaryBlue,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _IconList extends StatelessWidget {
  final String title;
  final List<String> items;
  final IconData icon;
  final Color iconColor;

  const _IconList({
    required this.title,
    required this.items,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 20),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: iconColor, size: 18),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(color: Colors.grey[700], height: 1.4),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

