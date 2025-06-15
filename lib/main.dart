import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voice_medication_coach/screens/splash_screen.dart';
import 'package:voice_medication_coach/screens/auth/auth_gateway_screen.dart';
import 'package:voice_medication_coach/screens/auth/login_screen.dart';
import 'package:voice_medication_coach/screens/auth/signup_screen.dart';
import 'package:voice_medication_coach/screens/home_screen.dart';
import 'package:voice_medication_coach/screens/my_medications_screen.dart';
import 'package:voice_medication_coach/screens/add_edit_medication_screen.dart';
import 'package:voice_medication_coach/screens/reminders_screen.dart';
import 'package:voice_medication_coach/screens/assistant_chat_screen.dart';
import 'package:voice_medication_coach/screens/profile_screen.dart';
import 'package:voice_medication_coach/screens/settings_screen.dart';
import 'package:voice_medication_coach/screens/mood_tracker_screen.dart';
import 'package:voice_medication_coach/theme/app_theme.dart';
import 'package:voice_medication_coach/screens/summary_chart_screen.dart';
import 'package:voice_medication_coach/screens/guidelines_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.system);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, currentThemeMode, child) {
        return MaterialApp(
          title: 'Voice Medication Coach',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentThemeMode,
          home: const SplashScreen(),
          routes: {
            '/auth_gateway': (context) => const AuthGatewayScreen(),
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignupScreen(),
            '/home': (context) => const HomeScreen(),
            '/dashboard': (context) => const Scaffold(body: Center(child: Text('Dashboard Screen'))),
            '/my_medications': (context) => const MyMedicationsScreen(),
            '/add_edit_medication': (context) => const AddEditMedicationScreen(),
            '/reminders': (context) => const RemindersScreen(),
            '/assistant_chat': (context) => const AssistantChatScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/settings': (context) => SettingsScreen(themeModeNotifier: themeModeNotifier),
            '/mood_tracker': (context) => const MoodTrackerScreen(),
            '/summary_chart': (context) => const SummaryChartScreen(),
            '/guidelines': (context) => const GuidelinesScreen(),
          },
        );
      },
    );
  }
}
