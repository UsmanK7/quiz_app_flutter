class QuestionModel{
  final String question;
  final String imgUrl;
  final List<String> options;
  final int correctAnswerIndex;

  const QuestionModel({required this.question,required this.imgUrl,required this.options, required this.correctAnswerIndex});
}