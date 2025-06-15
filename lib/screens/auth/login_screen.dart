import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:voice_medication_coach/screens/summary_chart_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isOtpSent = false;
  String _selectedRole = 'User'; // Default role

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Welcome Back!',
                style: textTheme.headlineMedium?.copyWith(color: colorScheme.onBackground),
              ),
              const SizedBox(height: 8),
              Text(
                'Please sign in to continue',
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 40),
              
              // Role Selection
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.outline),
                  borderRadius: BorderRadius.circular(8),
                  color: colorScheme.surface,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedRole,
                    isExpanded: true,
                    items: ['User', 'Health Worker']
                        .map((role) => DropdownMenuItem(
                              value: role,
                              child: Text(role, style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value!;
                      });
                    },
                    dropdownColor: colorScheme.surface,
                    iconEnabledColor: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number or Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.phone_android, color: colorScheme.onSurfaceVariant),
                  labelStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                  hintStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
                keyboardType: TextInputType.phone,
                enabled: !_isOtpSent, // Disable input after OTP is "sent"
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
              ),
              const SizedBox(height: 24),

              if (_isOtpSent) ...[
                // OTP Input is only shown if OTP is "sent"
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: _otpController,
                  onChanged: (value) {},
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: colorScheme.surface,
                    inactiveFillColor: colorScheme.surface,
                    selectedFillColor: colorScheme.surface,
                    activeColor: colorScheme.primary,
                    inactiveColor: colorScheme.outline,
                    selectedColor: colorScheme.primary,
                  ),
                  textStyle: textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface),
                  cursorColor: colorScheme.primary,
                ),
                const SizedBox(height: 24),
              ],

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_isOtpSent) {
                      // Logic for "Send OTP"
                      // TODO: Implement OTP sending logic using Firebase Auth
                      setState(() {
                        _isOtpSent = true;
                      });
                    } else {
                      // Logic for "Verify OTP"
                      // TODO: Implement OTP verification using Firebase Auth

                      if (_selectedRole == 'User') {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        Navigator.pushReplacementNamed(context, '/dashboard');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary, // Make button visible
                    foregroundColor: colorScheme.onPrimary, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    _isOtpSent ? 'Verify OTP' : 'Send OTP',
                    style: textTheme.labelLarge, // Use theme text style
                  ),
                ),
              ),
              if (_isOtpSent)
                Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _isOtpSent = false;
                        _otpController.clear(); // Clear OTP when changing phone number
                      });
                    },
                    style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
                    child: Text('Resend OTP or Change Phone Number', style: textTheme.bodyMedium),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }
} 