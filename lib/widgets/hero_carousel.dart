import 'package:flutter/material.dart' hide CarouselController;
import 'package:carousel_slider/carousel_slider.dart';
import '../data/tour_data.dart';
import '../config/app_theme.dart';

class HeroCarousel extends StatelessWidget {
  const HeroCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 600,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
          ),
          items: TourData.heroImages.map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePath),
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
                            Colors.black.withValues(alpha: 0.3),
                            Colors.black.withValues(alpha: 0.5),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome To Cape Town',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width < 600 ? 32 : 48,
                    ),
              ),
              const SizedBox(height: 20),
              Text(
                'ITS NICE TO MEET YOU',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppTheme.accentOrange,
                      fontSize: MediaQuery.of(context).size.width < 600 ? 18 : 24,
                      letterSpacing: 2.0,
                    ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                ),
                child: const Text('TELL ME MORE'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
