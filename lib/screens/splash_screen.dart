import 'package:flutter/material.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:voice_medication_coach/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isChecking = true;
  String _statusMessage = 'Initializing...';
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
    _checkDeviceRequirements();
  }

  Future<void> _checkDeviceRequirements() async {
    try {
      // Check internet connectivity
      setState(() => _statusMessage = 'Checking internet connection...');
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // Don't throw exception, just show warning
        setState(() => _statusMessage = 'No internet connection - some features may be limited');
        await Future.delayed(const Duration(seconds: 2));
      }

      // Check microphone permission
      setState(() => _statusMessage = 'Checking microphone permission...');
      final micStatus = await Permission.microphone.status;
      if (!micStatus.isGranted) {
        await Permission.microphone.request();
        if (!(await Permission.microphone.status).isGranted) {
          // Don't throw exception, just show warning
          setState(() => _statusMessage = 'Microphone permission recommended for voice features');
          await Future.delayed(const Duration(seconds: 2));
        }
      }

      setState(() {
        _isChecking = false;
        _statusMessage = 'Ready!';
      });

      // Navigate to next screen after successful checks
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _statusMessage = 'Error: ${e.toString()}';
      });
      
      // Still navigate to next screen even if there are permission issues
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.surfaceVariant,
              colorScheme.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Animation
                ScaleTransition(
                  scale: _animation,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      shape: BoxShape.rectangle,
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/my_onsite_healthcare_logo.jpeg',
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                
                // App Title
                FadeTransition(
                  opacity: _animation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Voice Medication Coach',
                    style: textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                
                // Tagline
                FadeTransition(
                  opacity: _animation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Your Personal Health Assistant',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                
                // Status Message
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey(_statusMessage),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: _hasError ? colorScheme.errorContainer : colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_isChecking)
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _hasError ? colorScheme.error : colorScheme.primary,
                              ),
                            ),
                          )
                        else
                          Icon(
                            _hasError ? Icons.error_outline : Icons.check_circle_outline,
                            color: _hasError ? colorScheme.error : colorScheme.primary,
                            size: 20,
                          ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                          _statusMessage,
                          style: textTheme.bodyMedium?.copyWith(
                            color: _hasError ? colorScheme.onErrorContainer : colorScheme.onPrimaryContainer,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 