class Score {
  final int score;
  final int quiz_subject;
  const Score({required this.score, required this.quiz_subject});
  factory Score.fromJson(Map<String, dynamic> json) => Score(
        score: json["score"],
        quiz_subject: json["quiz_subject"],
    );

    Map<String, dynamic> toJson() => {
        "score": score,
        "quiz_subject": quiz_subject,
    };
}