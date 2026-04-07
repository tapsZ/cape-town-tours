import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_theme.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onScrollToServices;
  final VoidCallback? onScrollToTours;
  final VoidCallback? onScrollToTeam;

  const NavBar({
    super.key,
    this.onScrollToServices,
    this.onScrollToTours,
    this.onScrollToTeam,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return AppBar(
      backgroundColor: Colors.white.withValues(alpha: 0.9),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      leading: isMobile ? null : const SizedBox.shrink(),
      leadingWidth: isMobile ? null : 0,
        title: InkWell(
          onTap: () => context.go('/'),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 40,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "CAPE BEST TOURS",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: AppTheme.primaryBlue,
                          fontSize: isMobile ? 18 : 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                  ),
                  if (!isMobile)
                    const Text(
                      'Authentic Cape Town Experiences',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppTheme.textLight,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      actions: isMobile
          ? [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: AppTheme.primaryBlue),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
              const SizedBox(width: 10),
            ]
          : [
              _NavBarAction(
                label: 'HOME',
                onPressed: () => context.go('/'),
              ),
              _NavBarAction(
                label: 'SERVICES',
                onPressed: () => _scrollToSection(context, 'services'),
              ),
              _NavBarAction(
                label: 'TOURS',
                onPressed: () => _scrollToSection(context, 'tours'),
              ),
              _NavBarAction(
                label: 'GUIDES',
                onPressed: () => _scrollToSection(context, 'team'),
              ),
              _NavBarAction(
                label: 'CONTACT',
                onPressed: () => context.go('/contact'),
              ),
              const SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => context.go('/contact'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('BOOK NOW'),
                ),
              ),
              const SizedBox(width: 20),
            ],
    );
  }

  void _scrollToSection(BuildContext context, String sectionId) {
    if (GoRouterState.of(context).uri.path != '/') {
      context.go('/');
      // The home page will handle the scroll via the keys
    } else {
      switch (sectionId) {
        case 'services':
          onScrollToServices?.call();
          break;
        case 'tours':
          onScrollToTours?.call();
          break;
        case 'team':
          onScrollToTeam?.call();
          break;
      }
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}

class _NavBarAction extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _NavBarAction({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppTheme.textDark,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

