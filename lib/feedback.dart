import 'package:flutter/material.dart';

class FeedbackData {
  final String userName;
  final String feedbackText;
  final bool isParent;

  FeedbackData({
    required this.userName,
    required this.feedbackText,
    required this.isParent,
  });
}

List<FeedbackData> dummyFeedbacks = [
  FeedbackData(
    userName: 'Parent1',
    feedbackText: 'The app is amazing! My child loves it.',
    isParent: true,
  ),
  FeedbackData(
    userName: 'Student1',
    feedbackText: "I've learned so much from this app. It's great!",
    isParent: false,
  ),
  FeedbackData(
    userName: 'Parent2',
    feedbackText: 'The content is educational and engaging.',
    isParent: true,
  ),
  FeedbackData(
    userName: 'Student2',
    feedbackText: 'The quizzes are challenging and fun.',
    isParent: false,
  ),
  // Add more dummy feedback data here
];

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: ListView.builder(
        itemCount: dummyFeedbacks.length,
        itemBuilder: (context, index) {
          FeedbackData feedback = dummyFeedbacks[index];
          return ListTile(
            leading: Icon(feedback.isParent ? Icons.person : Icons.child_care),
            title: Text(feedback.userName),
            subtitle: Text(feedback.feedbackText),
          );
        },
      ),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FeedbackPage(),
    );
  }
}
