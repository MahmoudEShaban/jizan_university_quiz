import 'package:jizan_university_quiz/about/about.dart';
import 'package:jizan_university_quiz/home/home.dart';
import 'package:jizan_university_quiz/login/login.dart';
import 'package:jizan_university_quiz/profile/profile.dart';
import 'package:jizan_university_quiz/topics/topics.dart';
import 'package:jizan_university_quiz/quiz/AddQuizScreen.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) =>  LoginScreen(),
  '/topics': (context) =>  TopicsScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/about': (context) => const AboutScreen(),
  '/addQuiz': (context) => const AddQuiz(),
};
