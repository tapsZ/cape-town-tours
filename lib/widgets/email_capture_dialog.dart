import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmailCaptureDialog extends StatefulWidget {
  final String tourTitle;
  final Future<bool> Function(String email, {String? turnstileToken}) onSubmitted;
  final Map<String, String> settings;

  const EmailCaptureDialog({
    super.key,
    required this.tourTitle,
    required this.onSubmitted,
    this.settings = const {},
  });

  @override
  State<EmailCaptureDialog> createState() => _EmailCaptureDialogState();
}

class _EmailCaptureDialogState extends State<EmailCaptureDialog> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _turnstileKey = GlobalKey<FlutterCloudflareTurnstileState>();
  bool _isSubmitting = false;
  String? _turnstileToken;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(32),
        constraints: const BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications_active, color: Colors.amber, size: 48),
              ),
              const Gap(24),
              Text(
                'Get Notified!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Gap(12),
              Text(
                'We are finalizing our schedules for the ${widget.tourTitle}. Leave your email and be the first to know when we launch!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700], height: 1.5),
              ),
              const Gap(32),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Your Email Address',
                  prefixIcon: const Icon(Icons.email_outlined),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter your email';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const Gap(32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _isSubmitting = true);
                      
                      if (widget.settings['TURNSTILE_ENABLED'] == 'true') {
                        _turnstileToken = await _turnstileKey.currentState?.getResponse();
                        if (_turnstileToken == null) {
                          setState(() => _isSubmitting = false);
                          return;
                        }
                      }

                      final success = await widget.onSubmitted(_emailController.text, turnstileToken: _turnstileToken);
                      if (!context.mounted) return;

                      if (success) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Awesome! We will be in touch soon.'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        setState(() => _isSubmitting = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Submission failed. Please try again.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: _isSubmitting 
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('NOTIFY ME', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                ),
              ),
              const Gap(16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Maybe later', style: TextStyle(color: Colors.grey[500])),
              ),
              if (widget.settings['TURNSTILE_ENABLED'] == 'true')
                Opacity(
                  opacity: 0,
                  child: SizedBox(
                    height: 0,
                    child: FlutterCloudflareTurnstile(
                      key: _turnstileKey,
                      siteKey: widget.settings['TURNSTILE_SITE_KEY'] ?? '',
                      onTokenRecived: (token) => _turnstileToken = token,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

