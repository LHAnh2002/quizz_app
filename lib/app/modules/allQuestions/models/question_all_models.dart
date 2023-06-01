import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPaperModel {
  String id;
  String title;
  String? imageUrl;
  String description;
  int timeSeconds;
  int questionCount;
  List<AllQuestions>? questions;

  QuestionPaperModel(
      {required this.id,
      required this.title,
      this.imageUrl,
      required this.description,
      required this.timeSeconds,
      required this.questionCount,
      this.questions});

  QuestionPaperModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        imageUrl = json['image_url'] as String,
        description = json['Description'] as String,
        timeSeconds = json['time_seconds'],
        questionCount = 0,
        questions = (json['questions'] as List)
            .map(
                (dynamic e) => AllQuestions.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image_url'] = this.imageUrl;
    data['Description'] = this.description;
    data['time_seconds'] = this.timeSeconds;

    return data;
  }
}

class AllQuestions {
  String id;
  String id_title;
  String? imageUrl;
  String question;
  List<AllAnswers> answers;
  String correctAnswer;
  String selectedAnswer;

  AllQuestions(
      {required this.id,
      this.imageUrl,
      required this.id_title,
      required this.question,
      required this.answers,
      required this.selectedAnswer,
      required this.correctAnswer});

  factory AllQuestions.fromJson(Map<String, dynamic> json) {
    List<AllAnswers> answers = [];
    if (json['answers'] != null) {
      json['answers'].forEach((answer) {
        answers.add(AllAnswers.fromJson(answer));
      });
    }
    return AllQuestions(
      id: json['id'],
      id_title: json['id_title'],
      imageUrl: json['imageUrl'],
      question: json['question'],
      answers: answers,
      correctAnswer: json['correct_answer'],
      selectedAnswer: json['selected_answer'],
    );
  }

  AllQuestions.formSnapsort(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        imageUrl = json['image_url'],
        id_title = json['id_title'],
        question = json['question'],
        answers = [],
        selectedAnswer = json['selected_answer'],
        correctAnswer = json['correct_answer'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['image_url'] = this.imageUrl;
    data['question'] = this.question;
    data['id_title'] = this.id_title;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    data['correct_answer'] = this.correctAnswer;
    return data;
  }
}

class AllAnswers {
  String? identifier;
  String? answer;

  AllAnswers({this.identifier, this.answer});

  AllAnswers.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'],
        answer = json['answer'];

  AllAnswers.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : identifier = snapshot['identifier'] as String,
        answer = snapshot['answer'] as String;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['answer'] = this.answer;
    return data;
  }
}
