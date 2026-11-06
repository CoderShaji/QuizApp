import 'package:flutter/material.dart';
import 'package:quiz_student/widgets/alert_dialog.dart';
import 'package:quiz_student/services/quiz_lookup.dart';
import 'package:quiz_student/screens/quiz_take.dart';

void showquizcodesheet(BuildContext context) {
  TextEditingController codecontroller = TextEditingController();
  bool isLoading = false;
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (sheetContext) => StatefulBuilder(
      builder: (context, setModalState) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Enter Quiz Code',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ),
            ),
            TextFormField(
              controller: codecontroller,
              autofocus: true,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Enter Quiz Code',
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        final code = codecontroller.text.trim();
                        if (code.isEmpty) {
                          await erroralertdialog(
                            context: context,
                            title: 'Quiz Code Required',
                            content: 'Please enter a quiz code to continue.',
                          );
                          return;
                        }

                        setModalState(() {
                          isLoading = true;
                        });

                        try {
                          final quiz = await findQuizByCode(code);
                          if (!context.mounted) {
                            return;
                          }

                          if (quiz == null) {
                            await erroralertdialog(
                              context: context,
                              title: 'Invalid Code',
                              content: 'Such quiz does not exist.',
                            );
                            return;
                          }

                          Navigator.of(context).pop();
                          Navigator.of(sheetContext).push(
                            MaterialPageRoute(
                              builder: (_) => QuizTakeScreen(quiz: quiz),
                            ),
                          );
                        } on QuizLookupException catch (error) {
                          if (!context.mounted) {
                            return;
                          }
                          await erroralertdialog(
                            context: context,
                            title: 'Quiz Unavailable',
                            content: error.message,
                          );
                        } catch (_) {
                          if (!context.mounted) {
                            return;
                          }
                          await erroralertdialog(
                            context: context,
                            title: 'Error',
                            content:
                                'Could not load the quiz right now. Please try again.',
                          );
                        } finally {
                          if (context.mounted) {
                            setModalState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                child: isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      )
                    : const Text('Join Quiz'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
