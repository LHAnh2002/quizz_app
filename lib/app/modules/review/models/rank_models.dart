import 'package:cloud_firestore/cloud_firestore.dart';

class RankModer {
  String id;
  String email;
  String name;
  String profilepic;
  List<Rank>? rank;

  RankModer({
    required this.id,
    required this.email,
    required this.name,
    required this.profilepic,
    required this.rank,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['profilepic'] = this.profilepic;
    data['rank'] = this.rank!.map((rank) => rank.toJson()).toList();
    return data;
  }

  RankModer.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        email = snapshot['email'],
        name = snapshot['name'],
        profilepic = snapshot['profilepic'],
        rank = [];

  RankModer.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        name = json['name'],
        profilepic = json['profilepic'],
        rank = (json['rank'] as List<dynamic>)
            .map((rank) => Rank.fromJson(rank))
            .toList();
}

class Rank {
  String id;
  num points;
  String correct_answer;
  Timestamp times;
  num time;

  Rank({
    required this.id,
    required this.points,
    required this.correct_answer,
    required this.times,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'points': points,
        'correct_answer': correct_answer,
        'times': times,
        'time': time,
      };

  factory Rank.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Rank(
      id: snapshot.id,
      points: data['points'],
      correct_answer: data['correct_answer'],
      times: data['times'],
      time: data['time'],
    );
  }

  factory Rank.fromJson(Map<String, dynamic> json) => Rank(
        id: json['id'],
        points: json['points'],
        correct_answer: json['correct_answer'],
        times: json['times'],
        time: json['time'],
      );
}
