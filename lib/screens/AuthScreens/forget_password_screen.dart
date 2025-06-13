import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});



  final TextEditingController _emailController = TextEditingController();

  void _handleSendOtp(BuildContext context, String email) async {
    // final success = await sendOtpToEmail(email); // backend call if available

    ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
    content: const Text(
      'If this email is registered, an OTP has been sent.',
      style: TextStyle(fontSize: 16),
    ),
    behavior: SnackBarBehavior.floating, // floats instead of pushing content
    margin: const EdgeInsets.all(16),     // adds spacing around it
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    duration: const Duration(seconds: 4),
  ),
      
    );

    Navigator.pushNamed(context, '/verify-otp');
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F2FC),
      body: Center(
        child: Container(
          width: isDesktop ? 420 : double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Card(
            elevation: 12,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Forgot Your Password?',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Enter your email address to reset your password.',
                    style: TextStyle(fontSize: 14, color: Color(0xFF9A9A9A)),
                  ),
                  const SizedBox(height: 32),

                  // Email field
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.black87),
                      filled: true,
                      fillColor: const Color(0xFFF5F6FA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Reset Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        final email = _emailController.text.trim();
                        _handleSendOtp(context, email);
                      },
                      child: const Text(
                        'Send Reset Link',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Back to Login
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back
                    },
                    child: const Text(
                      'Back to Login',
                      style: TextStyle(color: Color(0xFF9A9A9A)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
