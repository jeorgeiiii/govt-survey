import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../l10n/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isLoading = false;
  bool _otpSent = false;
  String? _verificationId;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendOTP() async {
    if (_phoneController.text.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      // Check for dev phone number
      if (_phoneController.text == '2525252525') {
        // Dev mode - skip Supabase
        setState(() {
          _otpSent = true;
          _isLoading = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Dev mode: Enter 000000 as OTP'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }

      // Format phone number with country code
      String phoneNumber = '+91${_phoneController.text}';

      await Supabase.instance.client.auth.signInWithOtp(
        phone: phoneNumber,
      );

      setState(() {
        _otpSent = true;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.enterOtp),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _verifyOTP() async {
    if (_otpController.text.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      // Check for dev mode
      if (_phoneController.text == '2525252525' && _otpController.text == '000000') {
        // Dev mode - skip Supabase verification
        setState(() => _isLoading = false);
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/survey');
        }
        return;
      }

      final response = await Supabase.instance.client.auth.verifyOTP(
        phone: '+91${_phoneController.text}',
        token: _otpController.text,
        type: OtpType.sms,
      );

      if (response.user != null) {
        // Navigate to survey screen
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/survey');
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.invalidOtp),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.welcome),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),

              // Title
              FadeInDown(
                duration: const Duration(milliseconds: 680),
                child: Text(
                  _otpSent ? l10n.enterOtp : l10n.phoneNumber,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Subtitle
              FadeInDown(
                delay: const Duration(milliseconds: 170),
                child: Text(
                  _otpSent
                      ? 'Enter the 6-digit code sent to +91${_phoneController.text}'
                      : l10n.enterPhoneNumber,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // Phone Number Input
              if (!_otpSent) ...[
                FadeInUp(
                  delay: const Duration(milliseconds: 340),
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: l10n.phoneNumber,
                      prefixText: '+91 ',
                      prefixStyle: const TextStyle(color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.green, width: 2),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Send OTP Button
                FadeInUp(
                  delay: const Duration(milliseconds: 510),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _sendOTP,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              l10n.verify,
                              style: const TextStyle(fontSize: 18),
                            ),
                    ),
                  ),
                ),
              ] else ...[
                // OTP Input
                FadeInUp(
                  delay: const Duration(milliseconds: 340),
                  child: TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, letterSpacing: 8),
                    decoration: InputDecoration(
                      labelText: l10n.enterOtp,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.green, width: 2),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Verify OTP Button
                FadeInUp(
                  delay: const Duration(milliseconds: 510),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _verifyOTP,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              l10n.verify,
                              style: const TextStyle(fontSize: 18),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Resend OTP
                Center(
                  child: TextButton(
                    onPressed: _isLoading ? null : _sendOTP,
                    child: Text(
                      l10n.resendOtp,
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),
                ),
              ],

              const Spacer(),

              // Back to landing
              if (_otpSent)
                Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _otpSent = false;
                        _otpController.clear();
                      });
                    },
                    child: const Text('Change Phone Number'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
