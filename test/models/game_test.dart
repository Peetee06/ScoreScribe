import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ScoreScribe/models/game.dart';
import 'package:ScoreScribe/models/round.dart';

void main() {
  group('Game', () {
    final roundMap = {'mock': 0};
    final round = Round(roundMap);
    const uuid = '12345678';

    test('correctly constructs with defaults', () {
      final game = Game('TestGame');
      expect(game.id, isNotNull);
      expect(game.name, equals('TestGame'));
      expect(game.playerNames, isEmpty);
      expect(game.rounds, isNotEmpty);
    });

    test('correctly constructs with parameters', () {
      final game = Game(
        'TestGame',
        id: uuid,
        playerNames: ['Alice', 'Bob'],
        rounds: [round],
      );

      expect(game.id, equals(uuid));
      expect(game.name, equals('TestGame'));
      expect(game.playerNames, equals(['Alice', 'Bob']));
      expect(game.rounds, equals([round]));
    });

    test('toMap returns correct map', () {
      final game = Game(
        'TestGame',
        id: uuid,
        playerNames: ['Alice', 'Bob'],
        rounds: [round],
      );

      expect(
          game.toMap(),
          equals({
            'id': uuid,
            'name': 'TestGame',
            'playerNames': json.encode(['Alice', 'Bob']),
            'rounds': json.encode([
              {'scores': json.encode(roundMap)}
            ]),
          }));
    });

    test('fromMap correctly constructs game', () {
      final game = Game.fromMap({
        'id': uuid,
        'name': 'TestGame',
        'playerNames': json.encode(['Alice', 'Bob']),
        'rounds': json.encode([
          {'scores': json.encode(roundMap)}
        ]),
      });

      expect(game.id, equals(uuid));
      expect(game.name, equals('TestGame'));
      expect(game.playerNames, equals(['Alice', 'Bob']));
      expect(game.rounds.length, equals(1));
    });
  });
}
