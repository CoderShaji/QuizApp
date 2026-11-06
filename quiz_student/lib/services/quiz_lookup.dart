import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_student/models/q_a_model.dart';
import 'package:quiz_student/models/quiz_model.dart';

class QuizLookupException implements Exception {
  const QuizLookupException(this.message);

  final String message;

  @override
  String toString() => message;
}

Future<QuizModel?> findQuizByCode(String code) async {
  final cleanedCode = code.trim();
  if (cleanedCode.isEmpty) {
    return null;
  }

  final quizRef = FirebaseFirestore.instance.collection('Quiz').doc(cleanedCode);
  final quizSnapshot = await quizRef.get();

  if (!quizSnapshot.exists) {
    return null;
  }

  final quizMap = quizSnapshot.data();
  if (quizMap == null) {
    throw const QuizLookupException('Quiz data is missing.');
  }

  final questionSnapshot = await quizRef.collection('questions').get();
  final questions = questionSnapshot.docs
      .map((doc) => QAModel.fromJson(doc.data()))
      .toList();

  final quiz = QuizModel.fromJson(quizMap, questions);

  if (quiz.status == Status.saved) {
    throw const QuizLookupException(
      'This quiz is not published yet. Please contact your teacher.',
    );
  }

  if (quiz.status == Status.expired) {
    throw const QuizLookupException('This quiz has expired.');
  }

  if (questions.isEmpty) {
    throw const QuizLookupException('This quiz has no questions yet.');
  }

  return quiz;
}
