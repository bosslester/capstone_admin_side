import 'package:flutter/material.dart';
import 'app_state.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/shell.dart';

void main() {
  runApp(const FixItMonitorApp());
}

class FixItMonitorApp extends StatelessWidget {
  const FixItMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = const Color(0xFF7BD3F7);

    return MaterialApp(
      title: 'FixIt Wizard - Monitor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF1F6FC),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          isDense: true,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginPage(),
        '/signup': (_) => const SignUpPage(),
        '/home': (_) => const Shell(), // dashboard shell with left sidebar
      },
      // tiny guard: if not logged in and user tries deep link to /home
      onGenerateRoute: (settings) {
        if (settings.name == '/home' && !appState.isLoggedIn) {
          return MaterialPageRoute(builder: (_) => const LoginPage());
        }
        return null;
      },
    );
  }
}
