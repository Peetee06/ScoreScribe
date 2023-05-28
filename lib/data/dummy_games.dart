import 'package:spielblock/models/game.dart';
import 'package:spielblock/models/round.dart';

final List<Game> dummyGames = [
  Game(
    'Game 1',
    playerNames: ['Alice', 'Bob', 'Charlie'],
    rounds: [
      Round({'Alice': 5, 'Bob': 7, 'Charlie': 6}),
      Round({'Alice': 6, 'Bob': 8, 'Charlie': 7}),
    ],
  ),
  Game(
    'Game 2',
    playerNames: ['David', 'Eve', 'Frank'],
    rounds: [
      Round({'David': 5, 'Eve': 7, 'Frank': 6}),
      Round({'David': 6, 'Eve': 8, 'Frank': 7}),
    ],
  ),
];
