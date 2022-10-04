import 'package:flutter/material.dart';
import 'package:jizan_university_quiz/login/login.dart';
import 'package:jizan_university_quiz/shared/shared.dart';
import 'package:jizan_university_quiz/topics/topics.dart';
import 'package:jizan_university_quiz/services/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: ErrorMessage(),
          );
        } else if (snapshot.hasData) {
          return  TopicsScreen();
        } else {
          return  LoginScreen();
        }
      },
    );
  }
}