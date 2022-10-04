// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:jizan_university_quiz/services/models.dart';
//
// extension ListExtensions<E> on List<E> {
//   Map<String, E> asMapForFlutter() {
//     var data = asMap();
//     var result = <String, E>{};
//     data.forEach((index, element) {
//       result["$index"] = element;
//     });
//     return result;
//   }
// }
//
// class Option {
//   String value;
//   String detail;
//   bool correct;
//
//   Option({required this.value, required this.detail, required this.correct});
//
//   Map<String, dynamic> toMap() {
//     return {
//       "value": value,
//       "detail": detail,
//       "correct": correct
//     };
//   }
// }
//
// class QuestionModel {
//   String text;
//   List<Option> options;
//
//   QuestionModel({required this.text, this.options = const[]});
//
//   Map<String, dynamic> toMap() {
//     List<Map<String, dynamic>> optionsMapped = [];
//     for (var element in options) {
//       optionsMapped.add(element.toMap());
//     }
//     return {
//       "text": text,
//       "options": optionsMapped
//     };
//   }
// }
//
// class QuizDetailsModel {
//    final String id;
//    final String title;
//    final String topic;
//    final String description;
//    List<QuestionModel> questions;
//
//    QuizDetailsModel({required this.id, required this.title, required this.topic, required this.description, this.questions = const[]});
//
//   Map<String, dynamic> toMap() {
//     List<Map<String, dynamic>> questionsMapped = [];
//     for (var element in questions) {
//       questionsMapped.add(element.toMap());
//     }
//     return {
//       "id": id,
//       "title": title,
//       "topic": topic,
//       "description": description,
//       "questions": questionsMapped
//     };
//   }
// }
//
// // class QuizModel  {
// //   final String id;
// //   final String title;
// //   final String description;
// //   QuizDetailsModel? details;
// //
// //   QuizModel({required this.id, required this.title, required this.description, this.details});
// //
// //   Map<String, dynamic> toMap() {
// //     return {
// //       "id": id,
// //       "title": title,
// //       "description": description,
// //       "details": details?.toMap()
// //     };
// //   }
// // }
//
// class TopicModel {
//   final String id;
//   final String title;
//   List<QuizModelDetails> quizzes;
//
//   TopicModel({required this.id, required this.title, this.quizzes = const []});
//
//   Map<String, dynamic> toMap() {
//     List<Map<String, dynamic>> quizzesMapped = [];
//     for(var element in quizzes) {
//       quizzesMapped.add(element.toJson());
//     }
//     return {
//       "id": id,
//       "title": title,
//       "quizzes": quizzesMapped
//     };
//   }
// }
//
// class FirestoreManager {
//   FirebaseFirestore fs = FirebaseFirestore.instance;
//
//   /// Create new topic or replace existing one
//   Future<void> createTopic(TopicModel topic) async {
//     print("createTopic started");
//     var ref = fs.collection("topic").doc(topic.id);
//     await ref.set(topic.toMap(), SetOptions(merge: true));
//     print("createTopic ended");
//     print(ref);
//   }
//
//   /// replace all quizzes inside a topic
//   Future<Map> createQuiz({required String topicID,  List<QuizModelDetails>quizzes = const []}) async {
//     print("createQuiz started");
//    var ref = fs.collection("topic").doc(topicID);
//     print("createQuiz passed line 1");
//
//     // var data = quizzes.asMapForFlutter();
//    //  Map<String, dynamic> toSend = {};
//    //  data.forEach((key, value) {
//    //    toSend[key] = value.toMap();
//    //  });
//     await ref.set({"title": "$topicID", "quizzes": "$quizzes"});
//     print("createQuiz passed line 2");
//     var snapshot = await ref.get();
//     print(snapshot.data());
//     //await ref.update({"quizzes": "$quizzes"});
//     print("createQuiz passed line 3");
//     print(snapshot.data());
//     return snapshot.data() ?? {};
//
//     //print("createQuiz ended");
//   }
//
//
//   /// add new quiz to topic
//   Future<void> addQuizToTopic2({required String topicID, required List<QuizModelDetails> quiz}) async {
//     print("add quiz to topic started");
//     var ref = fs.collection("topic").doc("$topicID");
//     print("add quiz to topic entered");
//     List<Map<String, dynamic>> quizMapped = [];
//     for (var element in quiz){
//       quizMapped.add(element.toJson());
//     }
//     await ref.update({"quizzes": quizMapped});
//     print("add quiz to topic ended");
//   }
//
//   void addQuestionsToQuiz({required String topicID, required QuizDetailsModel quiz}) async {
//     var ref = fs.collection("topic/$topicID").doc("quizzes");
//     ref.set(quiz.toMap(), SetOptions(merge: true));
//   }
// }