import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/app_theme.dart';
import '../core/widgets/nav_bar.dart';
import '../core/widgets/footer.dart';
import '../widgets/whatsapp_button.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const NavBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _ContactHero(isMobile: isMobile),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 80,
                    horizontal: isMobile ? 20 : 60,
                  ),
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: _ContactBody(isMobile: isMobile),
                    ),
                  ),
                ),
                const Footer(),
              ],
            ),
          ),
          const WhatsAppButton(),
        ],
      ),
    );
  }
}

class _ContactHero extends StatelessWidget {
  final bool isMobile;
  const _ContactHero({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: const BoxDecoration(
        color: AppTheme.primaryBlue,
        image: DecorationImage(
          image: AssetImage('assets/images/portfolio/Cape-Town-City.jpg'),
          fit: BoxFit.cover,
          opacity: 0.2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Text(
            'GET IN TOUCH',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontSize: isMobile ? 40 : 72,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
          const SizedBox(height: 10),
          Text(
            'We\'d love to hear from you and help plan your perfect tour.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: isMobile ? 16 : 20,
              fontWeight: FontWeight.w300,
            ),
          ).animate(delay: 200.ms).fadeIn(),
        ],
      ),
    );
  }
}

class _ContactBody extends StatelessWidget {
  final bool isMobile;
  const _ContactBody({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        children: [
          _ContactDetails(),
          const SizedBox(height: 60),
          const _ContactForm(),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 1, child: _ContactDetails()),
        const SizedBox(width: 80),
        const Expanded(flex: 2, child: _ContactForm()),
      ],
    );
  }
}

class _ContactDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Information',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 40),
        _DetailCard(
          icon: Icons.location_on_outlined,
          title: 'Our Location',
          content: 'Cape Town, South Africa',
          onTap: () {},
        ),
        const SizedBox(height: 20),
        _DetailCard(
          icon: Icons.phone_outlined,
          title: 'Phone Number',
          content: '+27 12 345 6789',
          onTap: () => launchUrl(Uri.parse('tel:+27123456789')),
        ),
        const SizedBox(height: 20),
        _DetailCard(
          icon: Icons.email_outlined,
          title: 'Email Address',
          content: 'info@capebesttours.com',
          onTap: () => launchUrl(Uri.parse('mailto:info@capebesttours.com')),
        ),
        const SizedBox(height: 40),
        const Text(
          'Follow Us',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _SocialIcon(icon: Icons.facebook),
            const SizedBox(width: 15),
            _SocialIcon(icon: Icons.camera_alt),
            const SizedBox(width: 15),
            _SocialIcon(icon: Icons.business),
          ],
        ),
      ],
    );
  }
}

class _DetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final VoidCallback onTap;

  const _DetailCard({
    required this.icon,
    required this.title,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.primaryBlue, size: 24),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  const _SocialIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppTheme.primaryBlue, size: 20),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  Future<void> _sendWhatsApp() async {
    final name = _nameController.text;
    final message = _messageController.text;

    if (name.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in your name and message.')),
      );
      return;
    }

    final fullMessage = 'Hello! My name is $name.\n\n$message';
    final Uri url = Uri.parse('https://wa.me/27123456789?text=${Uri.encodeComponent(fullMessage)}');
    
    if (!await launchUrl(url)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open WhatsApp.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Keep In Touch',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 30),
          _TextField(
            controller: _nameController,
            label: 'Your Name',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 20),
          _TextField(
            controller: _emailController,
            label: 'Email Address',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          _TextField(
            controller: _messageController,
            label: 'Message',
            icon: Icons.chat_bubble_outline,
            maxLines: 5,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _sendWhatsApp,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 65),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chat_bubble),
                SizedBox(width: 15),
                Text(
                  'SEND VIA WHATSAPP',
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final int maxLines;
  final TextInputType keyboardType;

  const _TextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.primaryBlue, size: 20),
        filled: true,
        fillColor: AppTheme.backgroundLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppTheme.primaryBlue, width: 2),
        ),
      ),
    );
  }
}

