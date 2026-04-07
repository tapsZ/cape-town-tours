import 'package:flutter/material.dart';
import '../data/tour_data.dart';
import '../models/guide.dart';
import '../config/app_theme.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Text(
            'OUR AMAZING TEAM',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'Experience counts. Meet our veteran guides.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
          ),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 1;
              if (constraints.maxWidth > 500) crossAxisCount = 2;
              if (constraints.maxWidth > 800) crossAxisCount = 3;
              if (constraints.maxWidth > 1100) crossAxisCount = 4;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  childAspectRatio: 0.75,
                ),
                itemCount: TourData.guides.length,
                itemBuilder: (context, index) {
                  return _GuideCard(guide: TourData.guides[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  final Guide guide;

  const _GuideCard({required this.guide});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage(guide.imagePath),
        ),
        const SizedBox(height: 20),
        Text(
          guide.name,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 5),
        Text(
          'Experience: ${guide.experience}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialIcon(icon: Icons.alternate_email, url: guide.twitterUrl),
            const SizedBox(width: 10),
            _SocialIcon(icon: Icons.facebook, url: guide.facebookUrl),
            const SizedBox(width: 10),
            _SocialIcon(icon: Icons.business, url: guide.linkedinUrl),
          ],
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: AppTheme.textDark),
      ),
    );
  }
}
