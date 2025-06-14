import 'package:flutter/material.dart';
import 'package:webxhack/screens/AdminScreens/admin_dashboard.dart';
import 'package:webxhack/screens/AuthScreens/otp_screen.dart';
import 'package:webxhack/screens/AuthScreens/reset_password_screen.dart';
import 'package:webxhack/screens/DoctorScreens/council_screen.dart';
import 'package:webxhack/screens/DoctorScreens/home_doctor_screen.dart';
import 'package:webxhack/screens/DoctorScreens/dashboard_screen.dart';
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
      title: 'App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/admin-dash',
      routes: {
        '/': (context) => const LoginScreen(),
        '/forgot-password': (context) => ForgetPasswordScreen(),
        '/verify-otp': (context) => const OtpScreen(),
        '/reset-password': (context) => const ResetPasswordScreen(),
        '/matching-page': (context) => const OrganMatchingPage(),
        '/organs-patients-Page': (context) => const DashboardDoctor(),
        '/med-council': (context) => const MedicalCouncilScreen(),
        '/admin-dash': (context) => const AdminDashboard(),

      },
    );
  }
}
