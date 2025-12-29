import 'package:blog_app_clean_architecture/core/theme/theme.dart';
import 'package:blog_app_clean_architecture/features/auth/presentaion/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'features/auth/presentaion/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
