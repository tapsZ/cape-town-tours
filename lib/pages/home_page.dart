import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/widgets/nav_bar.dart';
import '../core/widgets/footer.dart';
import '../widgets/hero_carousel.dart';
import '../widgets/services_section.dart';
import '../widgets/tours_grid.dart';
import '../widgets/team_section.dart';
import '../widgets/cta_section.dart';
import '../widgets/social_proof_section.dart';
import '../widgets/whatsapp_button.dart';
import '../config/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _toursKey = GlobalKey();
  final GlobalKey _teamKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NavBar(
        onScrollToServices: () => _scrollToSection(_servicesKey),
        onScrollToTours: () => _scrollToSection(_toursKey),
        onScrollToTeam: () => _scrollToSection(_teamKey),
      ),
      endDrawer: _buildMobileDrawer(context),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                HeroCarousel(onScrollToTours: () => _scrollToSection(_toursKey)),
                ServicesSection(key: _servicesKey),
                ToursGrid(key: _toursKey),
                const SocialProofSection(),
                TeamSection(key: _teamKey),
                const CTASection(),
                const Footer(),
              ],
            ),
          ),
          const WhatsAppButton(),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppTheme.primaryBlue,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 50,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'CAPE BEST TOURS',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            _DrawerItem(
              icon: Icons.home,
              label: 'HOME',
              onTap: () {
                Navigator.pop(context);
                // Already here
              },
            ),
            _DrawerItem(
              icon: Icons.settings,
              label: 'SERVICES',
              onTap: () {
                Navigator.pop(context);
                _scrollToSection(_servicesKey);
              },
            ),
            _DrawerItem(
              icon: Icons.explore,
              label: 'TOURS',
              onTap: () {
                Navigator.pop(context);
                _scrollToSection(_toursKey);
              },
            ),
            _DrawerItem(
              icon: Icons.people,
              label: 'GUIDES',
              onTap: () {
                Navigator.pop(context);
                context.go('/guides');
              },
            ),
            _DrawerItem(
              icon: Icons.contact_support,
              label: 'CONTACT',
              onTap: () {
                Navigator.pop(context);
                // Navigate to contact
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('BOOK NOW'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryBlue),
      title: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
      onTap: onTap,
    );
  }
}

