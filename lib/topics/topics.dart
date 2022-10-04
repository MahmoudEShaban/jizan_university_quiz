import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jizan_university_quiz/services/firestore.dart';
import 'package:jizan_university_quiz/services/models.dart';
import 'package:jizan_university_quiz/shared/error.dart';
import 'package:jizan_university_quiz/shared/loading.dart';
import 'package:jizan_university_quiz/topics/drawer.dart';
import 'package:jizan_university_quiz/shared/bottom_nav.dart';
import 'package:jizan_university_quiz/topics/topic_item.dart';

class TopicsScreen extends StatelessWidget {
   TopicsScreen({super.key});

  FirestoreService firestoreService = FirestoreService();
  Future<void> run() async {
    await firestoreService.createTopic(topic: Topic(id: "Model1",title: "Model1"),quiz: [Quiz(id: "Model1",title: "First Quiz",description: "1desc")]);
    await firestoreService.createQuiz(Quiz(id: "Model1", title: "First Quiz", topic:"Model1", description: "description12"));
    await firestoreService.addQuizToTopic(topicID: "Model1", quiz: [QuizModelDetails(id: "Model1",description: "d",title: "Model1")]);
    await firestoreService.addQuestionToQuiz(quizID: "Model1", question: [Question(text: "Question11?")]);
    //await firestoreService.addOptionsToQuestion(quizID: "Model1",option: [Option(correct: true,value: "option1",detail: "First Detail")]);
    ///------------------------------------------------///
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          run();
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var topics = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: const Text('Topics'),
              actions: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.circleUser,
                    color: Colors.pink[200],
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.plus,
                    color: Colors.pink[200],
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/addQuiz'),
                )
              ],
            ),
            drawer: TopicDrawer(topics: topics),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: topics.map((topic) => TopicItem(topic: topic)).toList(),
            ),
            bottomNavigationBar: const BottomNavBar(),
          );
        } else {
          return const Text('No topics found in Firestore. Check database');
        }
      },
    );
  }
}