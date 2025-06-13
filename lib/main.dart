import 'package:flutter/material.dart';
import 'package:webxhack/screens/otp_screen.dart';
import 'screens/login_screen.dart';
import 'screens/forget_password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgetPasswordScreen(),
        '/verify-otp': (context) => const OtpScreen(),

      },
    );
  }
}
