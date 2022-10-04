import 'package:flutter/material.dart';
import 'package:jizan_university_quiz/services/models.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_admin/src/credential.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizState with ChangeNotifier {
  double _progress = 0;
  Option? _selected;

  final PageController controller = PageController();

  double get progress => _progress;
  Option? get selected => _selected;


  void initFirebaseAdminConn() async {
    var ref = FirebaseFirestore.instance.collection("topics").doc("angular");
    ref.set({
      "id": "angular",
      "img": "angular.png",
      "title": "Angular",
      "quizzes": [
        {
          "id": "",
          "title": "",
          "description": ""
        }
      ]
    }, SetOptions(merge: true));
  }

  set progress(double newValue) {
    _progress = newValue;
    notifyListeners();
  }

  set selected(Option? newValue) {
    _selected = newValue;
    notifyListeners();
  }

  void nextPage() async {
    await controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}
