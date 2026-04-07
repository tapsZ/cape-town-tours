import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_theme.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.9),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppBar(
        title: Text(
          "Cape Town's Best Tours",
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppTheme.primaryBlue,
                fontSize: 24,
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
      // In a real app, you'd handle the scroll after navigation
    } else {
      // Logic to scroll to section would go here
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
