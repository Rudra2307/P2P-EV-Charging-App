import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'auth/login/login_screen.dart';

void main() {
  runApp(const ChargerFinderApp());
}

class ChargerFinderApp extends StatelessWidget {
  const ChargerFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charger Finder',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}
