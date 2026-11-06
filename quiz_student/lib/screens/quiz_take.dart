import 'package:flutter/material.dart';
import 'package:quiz_student/models/quiz_result_model.dart';
import 'package:quiz_student/models/quiz_model.dart';
import 'package:quiz_student/models/q_a_model.dart';
import 'package:quiz_student/screens/results.dart';

class QuizTakeScreen extends StatefulWidget {
  final QuizModel quiz;
  const QuizTakeScreen({super.key, required this.quiz});

  @override
  State<QuizTakeScreen> createState() => _QuizTakeScreenState();
}

class _QuizTakeScreenState extends State<QuizTakeScreen> {
  int currentIndex = 0;
  int selectedAnswer = -1;
  late List<int> userAnswers;

  @override
  void initState() {
    super.initState();
    userAnswers = List<int>.filled(widget.quiz.questions.length, -1);
  }

  void _confirmAnswer() {
    if (selectedAnswer == -1) return;
    userAnswers[currentIndex] = selectedAnswer;
    if (currentIndex < widget.quiz.questions.length - 1) {
      setState(() {
        currentIndex += 1;
        selectedAnswer = userAnswers[currentIndex];
      });
      return;
    }

    // Quiz finished: calculate results
    int correctCount = 0;
    final List<QuizQuestionResult> questionResults = [];
    for (int i = 0; i < widget.quiz.questions.length; i++) {
      final question = widget.quiz.questions[i];
      final expected = question.correct_answer;
      final actual = userAnswers[i];
      if (actual == expected) correctCount += 1;
      questionResults.add(
        QuizQuestionResult(
          question: question,
          selectedAnswerIndex: actual,
          correctAnswerIndex: expected,
        ),
      );
    }
    final total = widget.quiz.questions.length;
    final percent = (correctCount / total * 100).round();

    if (!mounted) return;
    final result = QuizResultModel(
      quiz: widget.quiz,
      correctCount: correctCount,
      totalQuestions: total,
      percentage: percent,
      questionResults: questionResults,
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => Results(result: result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final QAModel q = widget.quiz.questions[currentIndex];
    final double progress = (currentIndex + 1) / widget.quiz.questions.length;

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0 ,
        title: Text(widget.quiz.quizTitle, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),)),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header: Question count and Timer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Question ${currentIndex + 1}/${widget.quiz.questions.length}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "04:32", // Placeholder for timer logic
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Progress Bar
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                color: Colors.black,
                minHeight: 4,
              ),
              const SizedBox(height: 40),
              // Question Text
              Center(
                child: Text(
                  q.question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Answer List
              Expanded(
                child: ListView.builder(
                  itemCount: q.answers.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: InkWell(
                        onTap: () => setState(() => selectedAnswer = i),
                        child: Container(
                          decoration: BoxDecoration(
                          color: Colors.white,
                            border: BoxBorder.all(color: Colors.black54,width: 1,),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(blurRadius: 1, offset: Offset(1,1))
                            ]
                          ),
                          padding: const EdgeInsets.all( 8.0),
                          child: Row(
                            children: [
                              Radio<int>(
                                value: i,
                                groupValue: selectedAnswer,
                                activeColor: Colors.black,
                                onChanged: (v) => setState(() => selectedAnswer = v ?? -1),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  q.answers[i],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Next Button
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: selectedAnswer == -1 ? null : _confirmAnswer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E232C), // Dark color from image
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      currentIndex < widget.quiz.questions.length - 1 ? 'Next' : 'Finish',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
