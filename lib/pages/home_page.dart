import 'package:flutter/material.dart';
import '../core/widgets/nav_bar.dart';
import '../core/widgets/footer.dart';
import '../widgets/hero_carousel.dart';
import '../widgets/services_section.dart';
import '../widgets/tours_grid.dart';
import '../widgets/team_section.dart';
import '../widgets/cta_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _teamKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NavBar(
        onScrollToServices: () => _scrollToSection(_servicesKey),
        onScrollToPortfolio: () => _scrollToSection(_portfolioKey),
        onScrollToTeam: () => _scrollToSection(_teamKey),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeroCarousel(),
            ServicesSection(key: _servicesKey),
            ToursGrid(key: _portfolioKey),
            TeamSection(key: _teamKey),
            const CTASection(),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
