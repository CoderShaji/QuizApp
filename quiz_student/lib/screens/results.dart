import 'package:flutter/material.dart';
import 'package:quiz_student/models/quiz_result_model.dart';

class Results extends StatelessWidget {
  const Results({super.key, this.result});

  final QuizResultModel? result;

  @override
  Widget build(BuildContext context) {
    final data = result;

    if (data == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Results'),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'No quiz result to show yet. Complete a quiz to view detailed feedback.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
    }

    final wrongQuestions = data.wrongQuestions;
    final scoreColor = data.percentage >= 50 ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${data.correctCount}/${data.totalQuestions}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            Text(
              '${data.percentage}%',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: scoreColor,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F7F9),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.quiz.quizTitle,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Score: ${data.correctCount} out of ${data.totalQuestions}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Percentage: ${data.percentage}%',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: scoreColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              wrongQuestions.isEmpty
                  ? 'Perfect score. You answered every question correctly.'
                  : 'Review wrong answers',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            if (wrongQuestions.isEmpty)
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: const Text(
                  'Great work. There are no incorrect questions to review.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            for (int index = 0; index < wrongQuestions.length; index++)
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.red.shade100),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Question ${index + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.red.shade600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        wrongQuestions[index].question.question,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _AnswerTile(
                        title: 'Your answer',
                        value: wrongQuestions[index].selectedAnswerText,
                        backgroundColor: Colors.red.withValues(alpha: 0.08),
                        textColor: Colors.red.shade700,
                        icon: Icons.close_rounded,
                      ),
                      const SizedBox(height: 10),
                      _AnswerTile(
                        title: 'Correct answer',
                        value: wrongQuestions[index].correctAnswerText,
                        backgroundColor: Colors.green.withValues(alpha: 0.10),
                        textColor: Colors.green.shade700,
                        icon: Icons.check_rounded,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AnswerTile extends StatelessWidget {
  const _AnswerTile({
    required this.title,
    required this.value,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
  });

  final String title;
  final String value;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
