import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/app_theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: const Color(0xFF1A1A1A),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              if (isMobile)
                Column(
                  children: _buildFooterSections(context),
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _buildFooterSections(context),
                ),
              const SizedBox(height: 60),
              const Divider(color: Colors.white10),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '© 2026 Cape Best Tours. All rights reserved.',
                    style: TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                  Row(
                    children: [
                      _FooterLink(label: 'Privacy', onPressed: () {}),
                      const SizedBox(width: 20),
                      _FooterLink(label: 'Terms', onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFooterSections(BuildContext context) {
    return [
      _FooterSection(
        title: 'ABOUT US',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 60,
              fit: BoxFit.contain,
              color: Colors.white, // Invert for dark footer
            ),
            const SizedBox(height: 20),
            const Text(
              'Providing premium, authentic Cape Town experiences for over 20 years. Licensed and registered professional guides.',
              style: TextStyle(color: Colors.white70, height: 1.6),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _SocialCircle(icon: Icons.facebook, url: 'https://facebook.com'),
                const SizedBox(width: 15),
                _SocialCircle(icon: Icons.camera_alt, url: 'https://instagram.com'),
                const SizedBox(width: 15),
                _SocialCircle(icon: Icons.alternate_email, url: 'mailto:info@capebesttours.com'),
              ],
            ),
          ],
        ),
      ),
      _FooterSection(
        title: 'QUICK LINKS',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FooterLinkButton(label: 'Home', onPressed: () => context.go('/')),
            _FooterLinkButton(label: 'Our Tours', onPressed: () => context.go('/')),
            _FooterLinkButton(label: 'Our Guides', onPressed: () => context.go('/guides')),
            _FooterLinkButton(label: 'Contact Us', onPressed: () => context.go('/contact')),
          ],
        ),
      ),
      _FooterSection(
        title: 'CONTACT',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ContactRow(icon: Icons.location_on, label: 'Cape Town, South Africa', isLink: true),
            _ContactRow(icon: Icons.phone, label: '+27 12 345 6789', isLink: true),
            _ContactRow(icon: Icons.email, label: 'info@capebesttours.com', isLink: true),
          ],
        ),
      ),
    ];
  }
}

class _FooterLinkButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _FooterLinkButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: onPressed,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  final String title;
  final Widget content;

  const _FooterSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 25),
          content,
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isLink;

  const _ContactRow({required this.icon, required this.label, this.isLink = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryBlue, size: 18),
          const SizedBox(width: 15),
          Expanded(
            child: InkWell(
              onTap: isLink ? () {} : null,
              child: Text(
                label,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

  }
}

class _SocialCircle extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialCircle({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _FooterLink({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        label,
        style: const TextStyle(color: Colors.white38, fontSize: 12),
      ),
    );
  }
}

