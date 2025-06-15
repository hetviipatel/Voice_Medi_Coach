import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voice_medication_coach/screens/auth/login_screen.dart'; // Import the new LoginScreen

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _numPages = 5; // Total number of onboarding pages

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _currentPage > 0
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
              )
            : null,
        actions: [
          if (_currentPage < _numPages - 1)
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/auth_gateway');
              },
              child: Text(
                'Skip',
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: const [
                  OnboardingPage(
                    imagePath: 'assets/images/onboarding1.svg',
                    title: 'Welcome to Voice Medication Coach',
                    description: 'Your dedicated companion for staying on track with your medication. We help you manage your health with intelligent reminders and voice-enabled tracking.',
                  ),
                  OnboardingPage(
                    imagePath: 'assets/images/onboarding2.svg',
                    title: 'Smart & Personalized Reminders',
                    description: 'Set up custom medication schedules and receive timely reminders tailored to your daily routine. Never miss a dose again with our intuitive reminder system.',
                  ),
                  OnboardingPage(
                    imagePath: 'assets/images/onboarding3.svg',
                    title: 'Effortless Voice Reporting',
                    description: 'Simply speak to report your doses! Our multilingual voice assistant makes logging missed or taken medications quick and hassle-free, even when your hands are full.',
                  ),
                  OnboardingPage(
                    imagePath: 'assets/images/onboarding4.svg', // New placeholder
                    title: 'How to Use: Set Reminders',
                    description: 'Easily add new medications and define their schedules. Choose daily, weekly, or specific time reminders, and get notified on your device.',
                  ),
                  OnboardingPage(
                    imagePath: 'assets/images/onboarding5.svg', // New placeholder
                    title: 'How to Use: Voice Log',
                    description: 'After a reminder, just say "I took my medication" or "I missed my dose" to update your adherence record instantly. It\'s that simple!',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _numPages, // Use _numPages here
                      (index) => buildDot(index, context),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (_currentPage == _numPages - 1) // Show language selection and consent on the last page
                    Column(
                      children: [
                        // Language Selection Placeholder
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: 'English', // Default value
                              icon: Icon(Icons.arrow_drop_down, color: colorScheme.onSurfaceVariant),
                              elevation: 16,
                              style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
                              onChanged: (String? newValue) {
                                // TODO: Implement language change logic (e.g., using a state management solution)
                                // Consider using a logging framework instead of print in production.
                                // print('Selected language: $newValue');
                              },
                              items: <String>['English', 'Spanish', 'French'] // Example languages
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Consent Form Placeholder
                        CheckboxListTile(
                          title: Text(
                            'I agree to voice input, data storage, and notifications.',
                            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
                          ),
                          value: false, // TODO: Manage consent state
                          onChanged: (bool? newValue) {
                            // TODO: Implement consent logic and persist the state.
                            // Consider using a logging framework instead of print in production.
                            // print('Consent: $newValue');
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: colorScheme.primary,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // The Skip button is now in the AppBar
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          if (_currentPage < _numPages - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          } else {
                            Navigator.pushReplacementNamed(context, '/auth_gateway');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          _currentPage < _numPages - 1 ? 'Next' : 'Finish',
                          style: textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? colorScheme.primary : colorScheme.outline,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 4,
          child: Center(
            child: SvgPicture.asset(
              imagePath,
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width * 0.7, // Slightly larger for better visibility
              height: MediaQuery.of(context).size.height * 0.4, // Adjust height as needed
              colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn), // Apply theme color to SVG
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onBackground, // Use theme onBackground color
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant, // Use theme onSurfaceVariant color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 