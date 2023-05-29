import 'dart:convert';

import 'package:spielblock/models/round.dart';
import 'package:spielblock/utils/uuid_helper.dart';

class Game {
  final String id;
  String name;
  List<String> playerNames;
  List<Round> rounds;

  Game(
    this.name, {
    this.playerNames = const [],
    List<Round>? rounds,
    String? id,
  })  : id = id ?? generateUuid(),
        rounds = [
          Round(
            {
              for (final name in playerNames) name: 0,
            },
          ),
        ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'playerNames': json.encode(playerNames),
      'rounds': json.encode(rounds.map((round) => round.toMap()).toList()),
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      map['name'],
      id: map['id'],
      playerNames: List<String>.from(json.decode(map['playerNames'])),
      rounds: List<Round>.from(
        json.decode(map['rounds']).map(
              (roundMap) => Round.fromMap(roundMap),
            ),
      ),
    );
  }
}
