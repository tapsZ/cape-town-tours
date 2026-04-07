import 'package:flutter/material.dart';
import '../core/widgets/nav_bar.dart';
import '../core/widgets/footer.dart';
import '../widgets/hero_carousel.dart';
import '../widgets/services_section.dart';
import '../widgets/tours_grid.dart';
import '../widgets/team_section.dart';
import '../widgets/cta_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HeroCarousel(),
            ServicesSection(key: ValueKey('services')),
            ToursGrid(key: ValueKey('portfolio')),
            TeamSection(key: ValueKey('team')),
            CTASection(),
            Footer(),
          ],
        ),
      ),
    );
  }
}
