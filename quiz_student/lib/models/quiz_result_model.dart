import 'package:quiz_student/models/q_a_model.dart';
import 'package:quiz_student/models/quiz_model.dart';

class QuizQuestionResult {
  QuizQuestionResult({
    required this.question,
    required this.selectedAnswerIndex,
    required this.correctAnswerIndex,
  });

  final QAModel question;
  final int selectedAnswerIndex;
  final int correctAnswerIndex;

  bool get isCorrect => selectedAnswerIndex == correctAnswerIndex;

  String get selectedAnswerText {
    if (selectedAnswerIndex < 0 || selectedAnswerIndex >= question.answers.length) {
      return 'No answer selected';
    }
    return question.answers[selectedAnswerIndex];
  }

  String get correctAnswerText {
    if (correctAnswerIndex < 0 || correctAnswerIndex >= question.answers.length) {
      return 'Correct answer unavailable';
    }
    return question.answers[correctAnswerIndex];
  }
}

class QuizResultModel {
  QuizResultModel({
    required this.quiz,
    required this.correctCount,
    required this.totalQuestions,
    required this.percentage,
    required this.questionResults,
  });

  final QuizModel quiz;
  final int correctCount;
  final int totalQuestions;
  final int percentage;
  final List<QuizQuestionResult> questionResults;

  List<QuizQuestionResult> get wrongQuestions =>
      questionResults.where((result) => !result.isCorrect).toList();
}
