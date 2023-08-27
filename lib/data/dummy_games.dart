import 'package:scorescribe/models/game.dart';
import 'package:scorescribe/models/round.dart';

final List<Game> dummyGames = [
  Game(
    'Game 1',
    playerNames: ['Alice', 'Bob', 'Charlie'],
    rounds: [
      Round({'Alice': 5, 'Bob': 7, 'Charlie': 6}),
      Round({'Alice': 6, 'Bob': 8, 'Charlie': 7}),
      Round({'Alice': 7, 'Bob': 9, 'Charlie': 8}),
      Round({'Alice': 8, 'Bob': 10, 'Charlie': 9}),
      Round({'Alice': 9, 'Bob': 11, 'Charlie': 10}),
      Round({'Alice': 10, 'Bob': 12, 'Charlie': 11}),
      Round({'Alice': 11, 'Bob': 13, 'Charlie': 12}),
      Round({'Alice': 12, 'Bob': 14, 'Charlie': 13}),
      Round({'Alice': 13, 'Bob': 15, 'Charlie': 14}),
      Round({'Alice': 14, 'Bob': 16, 'Charlie': 15}),
    ],
  ),
  Game(
    'Game 2',
    playerNames: ['David', 'Eve', 'Frank'],
    rounds: [
      Round({'David': 5, 'Eve': 7, 'Frank': 6}),
      Round({'David': 6, 'Eve': 8, 'Frank': 7}),
      Round({'David': 7, 'Eve': 9, 'Frank': 8}),
      Round({'David': 8, 'Eve': 10, 'Frank': 9}),
      Round({'David': 9, 'Eve': 11, 'Frank': 10}),
      Round({'David': 10, 'Eve': 12, 'Frank': 11}),
      Round({'David': 11, 'Eve': 13, 'Frank': 12}),
      Round({'David': 12, 'Eve': 14, 'Frank': 13}),
      Round({'David': 13, 'Eve': 15, 'Frank': 14}),
      Round({'David': 14, 'Eve': 16, 'Frank': 15}),
    ],
  ),
];
