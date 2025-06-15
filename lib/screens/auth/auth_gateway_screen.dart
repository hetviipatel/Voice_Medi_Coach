import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthGatewayScreen extends StatelessWidget {
  const AuthGatewayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // App Logo or Placeholder
              Icon(
                Icons.medical_services,
                size: 120,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 48),
              Text(
                'Welcome to Voice Medication Coach',
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your dedicated companion for managing your medication with ease.',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 64),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Login',
                  style: textTheme.labelLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sign Up Button
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: colorScheme.primary, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: textTheme.labelLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
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