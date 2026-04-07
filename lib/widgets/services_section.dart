import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Text(
            'SERVICES',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'We make sure that you get where you want to be.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
          ),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: _ServiceCard(
                      iconPath: Icons.language,
                      title: 'Why Us?',
                      description: 'Our experienced team is gifted with almost all the international languages.',
                    )),
                    Expanded(child: _ServiceCard(
                      iconPath: Icons.directions_car,
                      title: 'Who we are',
                      description: 'We are a Tour Guiding Company, assisting you explore around Western Cape',
                    )),
                    Expanded(child: _ServiceCard(
                      iconPath: Icons.explore,
                      title: 'Where we are',
                      description: 'We offer our Tours Guides to any destination of your choice in Western Cape, South Africa.',
                    )),
                  ],
                );
              } else {
                return const Column(
                  children: [
                    _ServiceCard(
                      iconPath: Icons.language,
                      title: 'Why Us?',
                      description: 'Our experienced team is gifted with almost all the international languages.',
                    ),
                    SizedBox(height: 40),
                    _ServiceCard(
                      iconPath: Icons.directions_car,
                      title: 'Who we are',
                      description: 'We are a Tour Guiding Company, assisting you explore around Western Cape',
                    ),
                    SizedBox(height: 40),
                    _ServiceCard(
                      iconPath: Icons.explore,
                      title: 'Where we are',
                      description: 'We offer our Tours Guides to any destination of your choice in Western Cape, South Africa.',
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData iconPath;
  final String title;
  final String description;

  const _ServiceCard({
    required this.iconPath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(
            color: AppTheme.primaryBlue,
            shape: BoxShape.circle,
          ),
          child: Icon(iconPath, color: Colors.white, size: 60),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
