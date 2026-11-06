import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_student/models/q_a_model.dart';

enum Status { saved, expired, published, error }
List<QAModel> questionss = [
  QAModel(question: 'This is a long question which will be asked so it will take a lot of space lets see how it looks ', answers: answers, correct_answer: 2),
  QAModel(question: 'Answer this question with tsfasfdjl asdkfjlas asdlfka sdf;laksdf asd ;lasddf asdf a;sdkfj asdf a;lsdkf asdf sadlkf asdf asdf;lkk asdfa s', answers: answers, correct_answer: 2),
  QAModel(question: 'A quick Brown fox Jumps over the lazy ______? ', answers: answers, correct_answer: 2),
  QAModel(question: 'Q4', answers: answers, correct_answer: 2),
];
class QuizModel {
  String quizTitle, quizCode;
  int durationinmins;
  List<QAModel> questions;
  Status status;
  DateTime? publishedat;
  DateTime? expiresat;
  QuizModel({
    required this.quizTitle,
    required this.quizCode,
    required this.questions,
    required this.durationinmins,
    required this.status,
    this.publishedat,
    this.expiresat,
  });
  factory QuizModel.fromJson( Map<String, dynamic> quizmap, List<QAModel> questions) {
    Status statuss =Status.values.byName(quizmap['status'] ?? 'error');
    if(quizmap['expiresat']!=null){
    DateTime expiresat =(quizmap['expiresat'] as Timestamp).toDate();
    if(DateTime.now().isAfter(expiresat)&& statuss!= Status.error){
      statuss = Status.expired;
    }
    }
    return QuizModel(
      quizTitle: quizmap['quiztitle']?? ' ',
      
      quizCode: quizmap['quizcode']?? ' ',
      questions: questions,
      durationinmins:quizmap['time'],
      status: statuss,
      publishedat:quizmap['publishedat']==null? null:(quizmap['publishedat'] as Timestamp).toDate(),
      expiresat:quizmap['expiresat']==null?null:(quizmap['expiresat'] as Timestamp).toDate()
    );
  }
}

//FIXME:This function is just for now to quickly build history screen and results screen , soon will be replaced by Firestore or sharedprefs
//Some dummy quizzes for testing
final answers = ['some kind of long answer which will require two lines to fit in or it might cause an overflow, lets see', 'answer2', 'answer3', 'answer4'];

List<QuizModel> dummyquizzes = [
  QuizModel(
    quizTitle: 'Quiz1',
    quizCode: 'quizcode1',
    questions: questionss,
    durationinmins: 30,
    status: Status.error,
  ),
  QuizModel(
    quizTitle: 'Quiz2',
    quizCode: 'quizcode2',
    questions: questionss,
    durationinmins: 130,
    status: Status.published,
  ),
  QuizModel(
    quizTitle: 'Quiz3',
    quizCode: 'quizcode3',
    questions: questionss,
    durationinmins: 120,
    status: Status.saved,
  ),
];
