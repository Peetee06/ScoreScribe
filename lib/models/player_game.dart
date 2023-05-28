import 'package:spielblock/utils/uuid_helper.dart';

class PlayerGame {
  final String id;
  final String playerId;
  final String gameId;

  PlayerGame({required this.playerId, required this.gameId, String? id})
      : id = id ?? generateUuid();

  factory PlayerGame.fromMap(Map<String, dynamic> json) => PlayerGame(
        id: json["player_game_id"],
        playerId: json["player_id"],
        gameId: json["game_id"],
      );

  Map<String, dynamic> toMap() => {
        "player_game_id": id,
        "player_id": playerId,
        "game_id": gameId,
      };
}
