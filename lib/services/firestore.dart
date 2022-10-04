import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:jizan_university_quiz/services/auth.dart';
import 'package:jizan_university_quiz/services/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  /// Reads all documments from the topics collection
  Future<List<Topic>> getTopics() async {
    var ref = _db.collection('topics');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var topics = data.map((d) => Topic.fromJson(d));
    return topics.toList();
  }

  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);
    var snapshot = await ref.get();
    return Quiz.fromJson(snapshot.data() ?? {});
  }

  /// Retrieves a single quiz document

  Future<void> createTopic(
      {required Topic topic, List<Quiz> quiz = const []}) async {
    print("createTopic started");
    var ref = _db.collection("topics").doc(topic.id);
    List<Map<String, dynamic>> quizzesMapped = [];
    for (var element in quiz) {
      quizzesMapped.add(element.toJson());
    }
    await ref.update({"quizzes": quizzesMapped});
    await ref.set(topic.toJson(), SetOptions(merge: true));

    print("createTopic ended");
  }

  Future<void> createQuiz(Quiz quiz) async {
    print("create Quiz Started");
    var ref = _db.collection("quizzes").doc(quiz.id);
    await ref.set(quiz.toJson(), SetOptions(merge: true));
    print("create Quiz ended");
  }

  Future<void> addQuestionToQuiz(
      {required String quizID, List<Question> question = const []}) async {
    print("Add q to quiz started");
    var ref = _db.collection("quizzes").doc(quizID);
    List<Map<String, dynamic>> questionMapped = [];
    for (var element in question) {
      questionMapped.add(element.toJson());
    }

    await ref.update({"questions": questionMapped});
    print("Add q to quiz ended");
  }





  Future<void> addQuizToTopic(
      {required String topicID, required List<QuizModelDetails> quiz}) async {
    print("add quiz to topic started");
    var ref = _db.collection("topics").doc("$topicID");
    print("add quiz to topic entered");
    List<Map<String, dynamic>> quizMapped = [];
    for (var element in quiz) {
      quizMapped.add(element.toJson());
    }
    await ref.update({"quizzes": quizMapped});
    print("add quiz to topic ended");
  }

  /// Listens to current user's report document in Firestore
  Stream<Report> streamReport() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('reports').doc(user.uid);
        return ref.snapshots().map((doc) => Report.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([Report()]);
      }
    });
  }

  /// Updates the current user's report document after completing quiz
  Future<void> updateUserReport(Quiz quiz) {
    var user = AuthService().user!;
    var ref = _db.collection('reports').doc(user.uid);

    var data = {
      'total': FieldValue.increment(1),
      'topics': {
        quiz.topic: FieldValue.arrayUnion([quiz.id])
      }
    };

    return ref.set(data, SetOptions(merge: true));
  }
}

