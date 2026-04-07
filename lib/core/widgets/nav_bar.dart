import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_theme.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onScrollToServices;
  final VoidCallback? onScrollToPortfolio;
  final VoidCallback? onScrollToTeam;

  const NavBar({
    super.key,
    this.onScrollToServices,
    this.onScrollToPortfolio,
    this.onScrollToTeam,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withValues(alpha: 0.9),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppBar(
        title: InkWell(
          onTap: () => context.go('/'),
          child: Text(
            "Cape Town's Best Tours",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppTheme.primaryBlue,
                  fontSize: 24,
                ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          _NavBarAction(
            label: 'Services',
            onPressed: () => _scrollToSection(context, 'services'),
          ),
          _NavBarAction(
            label: 'Tours',
            onPressed: () => _scrollToSection(context, 'portfolio'),
          ),
          _NavBarAction(
            label: 'Team',
            onPressed: () => _scrollToSection(context, 'team'),
          ),
          _NavBarAction(
            label: 'Contact',
            onPressed: () => context.go('/contact'),
          ),
        ],
      ),
    );
  }

  void _scrollToSection(BuildContext context, String sectionId) {
    // If we're not on the home page, go there first
    if (GoRouterState.of(context).uri.path != '/') {
      context.go('/');
      // The home page will handle the scroll via the keys
    } else {
      switch (sectionId) {
        case 'services':
          onScrollToServices?.call();
          break;
        case 'portfolio':
          onScrollToPortfolio?.call();
          break;
        case 'team':
          onScrollToTeam?.call();
          break;
      }
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavBarAction extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _NavBarAction({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
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
