import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloudflare_turnstile/cloudflare_turnstile.dart';
import '../config/app_theme.dart';
import '../logic/cape_tours_state.dart';
import '../logic/cape_tours_cubit.dart';
import 'email_capture_dialog.dart';

class CTASection extends StatefulWidget {
  const CTASection({super.key});

  @override
  State<CTASection> createState() => _CTASectionState();
}

class _CTASectionState extends State<CTASection> {
  bool _hasLiked = false;
  bool _hasNotified = false;
  bool _isLiking = false;
  CloudflareTurnstile? _turnstile;
  String? _turnstileToken;

  @override
  void initState() {
    super.initState();
    _loadDedupeState();
  }

  @override
  void dispose() {
    _turnstile?.dispose();
    super.dispose();
  }

  void _ensureTurnstile(Map<String, String> settings) {
    if (_turnstile != null) return;
    if (settings['TURNSTILE_ENABLED'] != 'true') return;
    final siteKey = settings['TURNSTILE_SITE_KEY'];
    if (siteKey == null || siteKey.isEmpty) return;
    _turnstile = CloudflareTurnstile.invisible(
      siteKey: siteKey,
      onTokenReceived: (token) => _turnstileToken = token,
    );
  }

  Future<void> _loadDedupeState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _hasLiked = prefs.getBool('cbt_liked') ?? false;
      _hasNotified = prefs.getBool('cbt_notified') ?? false;
    });
  }

  Future<void> _handleLike(Map<String, String> settings) async {
    debugPrint('LIKE: click hasLiked=$_hasLiked isLiking=$_isLiking '
        'turnstileEnabled=${settings['TURNSTILE_ENABLED']} '
        'turnstileReady=${_turnstile != null}');
    if (_hasLiked || _isLiking) {
      debugPrint('LIKE: skipped (already liked or in-flight)');
      if (mounted && _hasLiked) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You already liked this. Thank you!')),
        );
      }
      return;
    }

    setState(() => _isLiking = true);

    try {
      final cubit = context.read<CapeToursCubit>();

      // Request new token if enabled
      if (settings['TURNSTILE_ENABLED'] == 'true') {
        _ensureTurnstile(settings);
        _turnstileToken = await _turnstile?.getToken();
        debugPrint('LIKE: turnstile token='
            '${_turnstileToken == null ? 'null' : '${_turnstileToken!.substring(0, _turnstileToken!.length < 12 ? _turnstileToken!.length : 12)}...(len=${_turnstileToken!.length})'}');
        if (_turnstileToken == null) {
          setState(() => _isLiking = false);
          debugPrint('LIKE: Turnstile verification check failed (no token produced)');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Verification check failed, please refresh and try again.')),
            );
          }
          return;
        }
      }

      debugPrint('LIKE: POST /likes (token=${_turnstileToken != null})');
      final result = await cubit.recordGeneralLike(_turnstileToken);
      debugPrint('LIKE: result=$result');

      if (result['success'] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('cbt_liked', true);
        setState(() {
          _hasLiked = true;
          _isLiking = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Thank you! We\'re glad you\'re excited about Cape Best Tours!'),
              backgroundColor: AppTheme.accentOrange,
            ),
          );
        }
      } else {
        setState(() => _isLiking = false);
        if (mounted) {
          final msg = result['message']?.toString() ?? 'Failed to record like. Please try again.';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)),
          );
        }
      }
    } catch (e, st) {
      debugPrint('LIKE error: $e\n$st');
      setState(() => _isLiking = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Couldn\'t reach server: $e')),
        );
      }
    }
  }

  void _handleNotify(BuildContext context, Map<String, String> settings) {
    if (_hasNotified) return;

    showDialog(
      context: context,
      builder: (context) => EmailCaptureDialog(
        tourTitle: 'Launch of Cape Best Tours',
        settings: settings,
        onSubmitted: (email, {turnstileToken}) async {
          final cubit = this.context.read<CapeToursCubit>();
          final result = await cubit.subscribeWaitlist(email, turnstileToken: turnstileToken);
          
          if (result['success'] == true) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('cbt_notified', true);
            setState(() => _hasNotified = true);
            return true;
          }
          return false;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return BlocBuilder<CapeToursCubit, CapeToursState>(
      builder: (context, state) {
        ImageProvider backgroundImage = const AssetImage('assets/images/portfolio/cape-town-city.webp');
        Map<String, String> settings = {};
        
        if (state is CapeToursLoaded) {
          settings = state.settings;
          if (state.ctaSectionImage != null) {
            backgroundImage = NetworkImage(state.ctaSectionImage!.url);
          }
          _ensureTurnstile(settings);
        }

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue,
            image: DecorationImage(
              image: backgroundImage,
              fit: BoxFit.cover,
              opacity: 0.15,
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 80 : 120,
            horizontal: 20,
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                children: [
                  Text(
                    'WE ARE PREPARING TO LAUNCH',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontSize: isMobile ? 32 : 56,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                        ),
                  ).animate().fadeIn().scale(delay: 200.ms),
                  const SizedBox(height: 24),
                  Text(
                    'We\'re putting the finishing touches on our premium Cape Town experiences. Join our exclusive waitlist and be the first to know when we go live.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: isMobile ? 16 : 20,
                      height: 1.6,
                      fontWeight: FontWeight.w300,
                    ),
                  ).animate(delay: 400.ms).fadeIn(),
                  const SizedBox(height: 60),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      _CTAButton(
                        text: _hasLiked ? 'LIKED ✓' : 'LIKE THE IDEA',
                        icon: _hasLiked ? Icons.favorite : Icons.favorite_border,
                        onPressed: (_hasLiked || _isLiking) ? () {} : () => _handleLike(settings),
                        isPrimary: true,
                        isLoading: _isLiking,
                        isDisabled: _hasLiked,
                      ),
                      _CTAButton(
                        text: _hasNotified ? 'NOTIFIED ✓' : 'GET NOTIFIED',
                        icon: Icons.notifications_active_outlined,
                        onPressed: _hasNotified ? () {} : () => _handleNotify(context, settings),
                        isPrimary: false,
                        isDisabled: _hasNotified,
                      ),
                    ],
                  ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.2, end: 0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CTAButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isLoading;
  final bool isDisabled;

  const _CTAButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.isPrimary,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isDisabled ? null : onPressed,
      icon: isLoading 
          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
          : Icon(icon, size: 20),
      label: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppTheme.accentOrange : Colors.white,
        foregroundColor: isPrimary ? Colors.white : AppTheme.primaryBlue,
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: isPrimary ? 10 : 0,
      ),
    );
  }
}

