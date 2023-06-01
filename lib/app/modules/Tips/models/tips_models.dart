import 'package:cloud_firestore/cloud_firestore.dart';

class TipsModels {
  String id;
  String title;
  List<Keyboard>? keyboard;
  TipsModels({
    required this.id,
    required this.title,
    this.keyboard,
  });
  TipsModels.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        title = json['title'],
        keyboard = [];
  factory TipsModels.fromJson(Map<String, dynamic> json) => TipsModels(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        keyboard: json['keyboard'] != null
            ? List<Keyboard>.from(
                json['keyboard'].map((x) => Keyboard.fromJson(x)))
            : null,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'keyboard': keyboard?.map((x) => x.toJson()).toList(),
      };
}

class Keyboard {
  String id;
  String title;
  List<Shortcutss>? shortcuts;
  Keyboard({
    required this.id,
    required this.title,
    this.shortcuts,
  });
  Keyboard.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        title = json['title'],
        shortcuts = [];

  factory Keyboard.fromJson(Map<String, dynamic> json) => Keyboard(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        shortcuts: json['shortcuts'] != null
            ? List<Shortcutss>.from(
                json['shortcuts'].map((x) => Shortcutss.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'shortcuts': shortcuts?.map((x) => x.toJson()).toList(),
      };
}

class Shortcutss {
  String id;
  String keys;
  String comment;
  Shortcutss({
    required this.id,
    required this.keys,
    required this.comment,
  });
  Shortcutss.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        keys = json['keys'],
        comment = json['comment'];

  factory Shortcutss.fromJson(Map<String, dynamic> json) => Shortcutss(
        id: json['id'] ?? '',
        keys: json['keys'] ?? '',
        comment: json['comment'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'keys': keys,
        'comment': comment,
      };
}
