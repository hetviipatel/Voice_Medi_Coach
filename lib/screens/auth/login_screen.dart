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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark ? colorScheme.surface : Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(theme.brightness == Brightness.dark ? 0.18 : 0.08),
                      blurRadius: 32,
                      offset: const Offset(0, 12),
                    ),
                  ],
                  gradient: theme.brightness == Brightness.dark
                      ? LinearGradient(
                          colors: [
                            colorScheme.surface,
                            colorScheme.primary.withOpacity(0.10),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            'assets/images/my_onsite_healthcare_logo.jpeg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Welcome Back!',
                        textAlign: TextAlign.center,
                        style: textTheme.headlineMedium?.copyWith(color: colorScheme.onBackground, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please sign in to continue',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 32),
                      // Role Selection
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: colorScheme.outline),
                          borderRadius: BorderRadius.circular(16),
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
                            borderRadius: BorderRadius.circular(16),
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
                        PinCodeTextField(
                          appContext: context,
                          length: 6,
                          controller: _otpController,
                          onChanged: (value) {},
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(16),
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
                              setState(() {
                                _isOtpSent = true;
                              });
                            } else {
                              if (_selectedRole == 'User') {
                                Navigator.pushReplacementNamed(context, '/home');
                              } else {
                                Navigator.pushReplacementNamed(context, '/dashboard');
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            _isOtpSent ? 'Verify OTP' : 'Send OTP',
                            style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      if (_isOtpSent)
                        Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _isOtpSent = false;
                                _otpController.clear();
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
            ),
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