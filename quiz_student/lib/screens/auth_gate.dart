import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_student/screens/auth/login_screen.dart';
import 'package:quiz_student/screens/auth/verify_email_screen.dart';
import 'package:quiz_student/screens/dashboard.dart';
import 'package:quiz_student/services/auth_service.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;
        if (user == null) {
          return const LoginScreen();
        }

        if (!user.emailVerified) {
          return const VerifyEmailScreen();
        }

        return const Dashboard();
      },
    );
  }
}
