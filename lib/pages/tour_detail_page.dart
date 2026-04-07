import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/tour_data.dart';
import '../models/tour.dart';
import '../config/app_theme.dart';
import '../core/widgets/nav_bar.dart';
import '../core/widgets/footer.dart';

class TourDetailPage extends StatelessWidget {
  final String slug;
  const TourDetailPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final tour = TourData.tours.firstWhere(
      (t) => t.slug == slug,
      orElse: () => TourData.tours.first,
    );

    return Scaffold(
      appBar: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TourHeader(tour: tour),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Column(
                    children: [
                      _TourInfoGrid(tour: tour),
                      const SizedBox(height: 60),
                      _TourHighlights(highlights: tour.highlights),
                    ],
                  ),
                ),
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class _TourHeader extends StatelessWidget {
  final Tour tour;
  const _TourHeader({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          tour.imagePath,
          width: double.infinity,
          height: 400,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: 400,
          color: Colors.black.withOpacity(0.4),
          child: Center(
            child: Text(
              tour.title.toUpperCase(),
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TourInfoGrid extends StatelessWidget {
  final Tour tour;
  const _TourInfoGrid({required this.tour});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _DescriptionSection(tour: tour)),
              const SizedBox(width: 40),
              Expanded(flex: 1, child: _BookingSidebar(tour: tour)),
            ],
          );
        } else {
          return Column(
            children: [
              _DescriptionSection(tour: tour),
              const SizedBox(height: 40),
              _BookingSidebar(tour: tour),
            ],
          );
        }
      },
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  final Tour tour;
  const _DescriptionSection({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          tour.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
              ),
        ),
      ],
    );
  }
}

class _BookingSidebar extends StatelessWidget {
  final Tour tour;
  const _BookingSidebar({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoRow(icon: Icons.access_time, label: tour.duration),
            const SizedBox(height: 15),
            _InfoRow(icon: Icons.group, label: tour.groupSize),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => launchUrl(Uri.parse('https://wa.me/27836694518?text=I would like to book the ${tour.title}')),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
              ),
              child: const Text('BOOK NOW'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryBlue, size: 24),
        const SizedBox(width: 15),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _TourHighlights extends StatelessWidget {
  final List<String> highlights;

  const _TourHighlights({required this.highlights});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Highlights',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: highlights.map((h) => _HighlightChip(label: h)).toList(),
        ),
      ],
    );
  }
}

class _HighlightChip extends StatelessWidget {
  final String label;

  const _HighlightChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue.withOpacity(0.05),
        border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppTheme.primaryBlue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
