import 'package:spielblock/utils/uuid_helper.dart';

class Player {
  final String id;
  final String name;

  Player({required this.name, String? id}) : id = id ?? generateUuid();

  factory Player.fromMap(Map<String, dynamic> json) => Player(
        id: json["player_id"],
        name: json["player_name"],
      );

  Map<String, dynamic> toMap() => {
        "player_id": id,
        "player_name": name,
      };
}
