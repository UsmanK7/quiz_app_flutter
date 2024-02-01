import 'package:flutter/material.dart';
import 'package:quiz_app_final/const/text_style.dart';
import 'package:quiz_app_final/score_model.dart';
import 'package:tuple/tuple.dart';
import 'main.dart';

import 'const/colors.dart';
class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.score,
    required this.quiz_subject,
  });
  final int quiz_subject;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [blue, darkBlue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 1000),
            const Text(
              'Your Score: ',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 250,
                  width: 250,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                    value: score / 9,
                    color: Colors.green,
                    backgroundColor: Colors.white,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      score.toString(),
                      style: const TextStyle(fontSize: 80, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  
                  // Creating a Tuple2 instance
                  Tuple2<int, int> resultTuple = Tuple2(quiz_subject, score);
        
                  // Adding the Tuple2 to the pairList in HomeScreen
                  HomeScreen.pairList.add(resultTuple);
                  HomeScreen.scorelist.add(Score(score: score, quiz_subject: quiz_subject));
                  saveIntoSp();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: normalText(
                    color: Colors.black, size: 15, text: "Back to Home"))
          ],
        ),
      ),
    );
  }
}
