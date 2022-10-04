import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jizan_university_quiz/services/services.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:jizan_university_quiz/routes.dart';
import 'package:jizan_university_quiz/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyD786kha1df6raFC_oo2GKP-DFFHBHqBjI",
        authDomain: "jizanquiz.firebaseapp.com",
        projectId: "jizanquiz",
        storageBucket: "jizanquiz.appspot.com",
        messagingSenderId: "877341211246",
        appId: "1:877341211246:web:0a2641b2dcd6c0ff0a047f",
        measurementId: "G-GCB6352QZG"
    ),
  );
  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});


  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();



  @override
  Widget build(BuildContext context) {
    return FutureBuilder (
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Directionality(textDirection: TextDirection.ltr,
          child: Text('I have error'));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider(
            create: (_) => FirestoreService().streamReport(),
            catchError: (_, err) => Report(),
            initialData: Report(),
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                routes: appRoutes,
                theme: appTheme),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Directionality(textDirection: TextDirection.ltr,
        child: Text('loading'));
      },
    );
  }
}