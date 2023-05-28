import 'package:spielblock/utils/uuid_helper.dart';

class Score {
  final String id;
  final String playerGameId;
  final String roundId;
  final int score;

  Score(
      {required this.playerGameId,
      required this.roundId,
      required this.score,
      String? id})
      : id = id ?? generateUuid();

  factory Score.fromMap(Map<String, dynamic> json) => Score(
        id: json["score_id"],
        playerGameId: json["player_game_id"],
        roundId: json["round_id"],
        score: json["score"],
      );

  Map<String, dynamic> toMap() => {
        "score_id": id,
        "player_game_id": playerGameId,
        "round_id": roundId,
        "score": score,
      };
}
