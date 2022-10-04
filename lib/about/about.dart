import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: const Center(child: Text('Press the button below')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
      // Add your onPressed code here!
    },
    backgroundColor: Colors.green,
    child: const Icon(Icons.add),
    ),
    );
  }
}
