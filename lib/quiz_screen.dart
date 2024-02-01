import 'package:flutter/material.dart';
import 'package:quiz_app_final/components/answer_card.dart';
import 'package:quiz_app_final/components/next_button.dart';
import 'package:quiz_app_final/const/images.dart';
import 'package:quiz_app_final/const/text_style.dart';
import 'const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'questions_answers/questions_model.dart';
import 'questions_answers/questions.dart';
import 'resultscreen.dart';


class QuizScreen extends StatefulWidget {
  final int selectedquiz;
  const QuizScreen({super.key, required this.selectedquiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  int score = 0;

  void pickAnswer(
    int value,
    List<QuestionModel> quizquestions,
  ) {
    selectedAnswerIndex = value;
    final question = quizquestions[questionIndex];
    if (selectedAnswerIndex == question.correctAnswerIndex) {
      score++;
    }
    setState(() {});
  }
  void goToNextQuestion(List<QuestionModel> quizquestions,) {
    if (questionIndex < quizquestions.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null;
    } 
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<QuestionModel> quizquestions = [];
    if (widget.selectedquiz == 0) {
      quizquestions = TraficQuestions;
    } else if (widget.selectedquiz == 1) {
      quizquestions = MathQuestions;
    } else {
      quizquestions = PhysicsQuestions;
    }
    final questionObject = quizquestions[questionIndex];
    bool isLastQuestion = questionIndex == quizquestions.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [blue, darkBlue],
          )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 2, color: lightgrey),
                      ),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            CupertinoIcons.back,
                            color: Colors.white,
                            size: 20,
                          )),
                    ),
                  ],
                ),
                if (questionObject.imgUrl.isNotEmpty)
                  Image(width: 180, image: NetworkImage(questionObject.imgUrl))
                else
                  Image(width: 180, image: AssetImage(ideas_img)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    normalText(color: Colors.white, size: 18, text: "Question "),
                    normalText(
                        color: Colors.white,
                        size: 18,
                        text: (questionIndex + 1).toString()),
                    normalText(color: Colors.white, size: 18, text: " of "),
                    normalText(
                        color: Colors.white,
                        size: 18,
                        text: (quizquestions.length).toString()),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                normalText(
                    color: Colors.white, size: 20, text: questionObject.question),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: questionObject.options.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: selectedAnswerIndex == null
                          ? () => pickAnswer(index, quizquestions)
                          : null,
                      child: AnswerCard(
                        currentIndex: index,
                        question: questionObject.options[index],
                        isSelected: selectedAnswerIndex == index,
                        selectedAnswerIndex: selectedAnswerIndex,
                        correctAnswerIndex: questionObject.correctAnswerIndex,
                      ),
                    );
                  },
                ),
                // Next Button
                isLastQuestion
                    ? RectangularButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => ResultScreen(
                                score: score,
                                quiz_subject: widget.selectedquiz,
                              ),
                            ),
                          );
                        },
                        label: 'Finish',
                      )
                    : RectangularButton(
                        onPressed: selectedAnswerIndex != null
                            ? () => goToNextQuestion(quizquestions)
                            : null,
                        label: 'Next',
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
