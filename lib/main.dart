import 'package:flutter/material.dart';
import 'package:webxhack/screens/AuthScreens/otp_screen.dart';
import 'package:webxhack/screens/AuthScreens/reset_password_screen.dart';
import 'package:webxhack/screens/DoctorScreens/home_screen.dart';
import 'screens/AuthScreens/login_screen.dart';
import 'screens/AuthScreens/forget_password_screen.dart';

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
      initialRoute: '/home-doctor',
      routes: {
        '/': (context) => const LoginScreen(),
        '/forgot-password': (context) => ForgetPasswordScreen(),
        '/verify-otp': (context) => const OtpScreen(),
        '/reset-password': (context) => const ResetPasswordScreen(),
        '/home-doctor': (context) => const OrganMatchingPage(),

      },
    );
  }
}
