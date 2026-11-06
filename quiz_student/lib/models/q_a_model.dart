import 'package:flutter/material.dart';
class QuestionControllers{
  final TextEditingController question = TextEditingController();
  final List<TextEditingController> answers = List.generate(4,(_)=>TextEditingController()) ;
  void dispose(){
    question.dispose();
    for(final c in answers){
      c.dispose();
    }
   
  }
}
class QAModel {
  String question ;
  List<String>answers;//Removed ? lets see if anything breaks
  int correct_answer;
  // QuestionControllers controller ;
  QAModel({required this.question, required this.answers, required this.correct_answer});
  factory QAModel.fromJson(Map<String, dynamic> questionmap){
    return QAModel(
      question:  questionmap['questionstatement']??' ', 
      answers: List<String>.from( questionmap['answers']),
       correct_answer: questionmap['correctanswer']
       );
  }

}
