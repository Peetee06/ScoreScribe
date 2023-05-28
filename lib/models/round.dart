import 'dart:convert';

class Round {
  final Map<String, int> scores;

  Round(this.scores);

  Map<String, dynamic> toMap() {
    return {
      'scores': json.encode(scores),
    };
  }

  factory Round.fromMap(Map<String, dynamic> map) {
    return Round(
      Map<String, int>.from(json.decode(map['scores'])),
    );
  }
}
