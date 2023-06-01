import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class TestKillQuestionPaperModel {
  String id;
  String title;
  String stt;
  String? correct;
  String? wrong;
  List<TestKillQuestions>? questions;

  TestKillQuestionPaperModel({
    required this.id,
    required this.title,
    required this.questions,
    required this.stt,
    this.correct,
    this.wrong,
  });

  factory TestKillQuestionPaperModel.fromJson(Map<String, dynamic> json) {
    List<TestKillQuestions>? questions = [];
    if (json['questions'] != null) {
      json['questions'].forEach((question) {
        questions.add(TestKillQuestions.fromJson(question));
      });
    }
    return TestKillQuestionPaperModel(
      id: json['id'],
      title: json['title'],
      stt: json['stt'],
      questions: questions,
      correct: json['correct'],
      wrong: json['wrong'],
    );
  }
  TestKillQuestionPaperModel.formSnapsort(
      DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        title = json['title'],
        stt = json['stt'],
        correct = json['correct'] ?? '',
        wrong = json['wrong'] ?? '',
        questions = [];

  get length => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['stt'] = this.stt;
    data['correct'] = this.correct;
    data['wrong'] = this.wrong;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((q) => q.toJson()).toList();
    }
    return data;
  }
}

class TestKillQuestions {
  String id;
  String id_title;
  String? imageUrl;
  String question;
  List<TestKillAnswers> answers;
  String? correctAnswer;
  String? selectedAnswer;

  TestKillQuestions(
      {required this.id,
      this.imageUrl,
      required this.id_title,
      required this.question,
      required this.answers,
      this.selectedAnswer,
      this.correctAnswer});

  factory TestKillQuestions.fromJson(Map<String, dynamic> json) {
    List<TestKillAnswers> answers = [];
    if (json['answers'] != null) {
      json['answers'].forEach((answer) {
        answers.add(TestKillAnswers.fromJson(answer));
      });
    }
    return TestKillQuestions(
      id: json['id'],
      id_title: json['id_title'],
      imageUrl: json['imageUrl'],
      question: json['question'],
      answers: answers,
      correctAnswer: json['correct_answer'],
      selectedAnswer: json['selected_answer'],
    );
  }

  TestKillQuestions.formSnapsort(DocumentSnapshot<Map<String, dynamic>> json)
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
    data['selected_answer'] = this.selectedAnswer;
    return data;
  }
}

class TestKillAnswers {
  String? identifier;
  String? answer;

  TestKillAnswers({this.identifier, this.answer});

  TestKillAnswers.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'],
        answer = json['answer'];

  TestKillAnswers.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : identifier = snapshot['identifier'] as String?,
        answer = snapshot['answer'] as String?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['answer'] = this.answer;
    return data;
  }
}
