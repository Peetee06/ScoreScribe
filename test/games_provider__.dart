import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spielblock/models/game.dart';
import 'package:spielblock/utils/database_helper.dart';
import 'package:spielblock/providers/games_provider.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  group('GamesNotifier', () {
    late MockDatabaseHelper databaseHelper;
    late ProviderContainer container;
    late GamesNotifier gamesNotifier;

    setUp(() {
      databaseHelper = MockDatabaseHelper();
      container = ProviderContainer(overrides: [
        gamesProvider.overrideWith(
          (ref) => GamesNotifier(dbHelper: databaseHelper),
        ),
      ]);
      gamesNotifier = container.read(gamesProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    test('getGames', () async {
      when(databaseHelper.query()).thenAnswer((_) async => [
            {
              'id': '1',
              'name': 'Test Game',
              'playerNames': json.encode(['Player 1', 'Player 2']),
              'rounds': json.encode([
                {
                  'scores': json.encode({'Player 1': 0, 'Player 2': 0})
                }
              ])
            }
          ]);

      await gamesNotifier.getGames();

      var state = container.read(gamesProvider);
      verify(databaseHelper.query()).called(1);
      expect(state, isNotEmpty);
      expect(state.first.id, equals('1'));
      expect(state.first.name, equals('Test Game'));
      expect(state.first.playerNames, containsAll(['Player 1', 'Player 2']));
      expect(state.first.rounds.first.scores, containsPair('Player 1', 0));
    });

    test('addGame', () async {
      var game = Game('New Game', playerNames: ['Player 1', 'Player 2']);

      gamesNotifier.addGame(game);

      var state = container.read(gamesProvider);

      verify(databaseHelper.insert).called(1);
      expect(state, isNotEmpty);
      expect(state.first.name, equals('New Game'));
      expect(state.first.playerNames, containsAll(['Player 1', 'Player 2']));
    });

    test('updateGame', () async {
      var game = Game('Initial Game', playerNames: ['Player 1', 'Player 2']);
      gamesNotifier.addGame(game); // Add the game first

      game = Game('Updated Game',
          id: game.id, playerNames: ['Player 1', 'Player 2']);

      gamesNotifier.updateGame(game); // Then update the game

      var state = container.read(gamesProvider);

      verify(databaseHelper.update).called(1);
      expect(state, isNotEmpty);
      expect(state.first.name, equals('Updated Game'));
    });

    test('deleteGame', () async {
      var game =
          Game('Game To Be Deleted', playerNames: ['Player 1', 'Player 2']);
      gamesNotifier.addGame(game); // Add the game first

      gamesNotifier.deleteGame(game); // Then delete the game

      var state = container.read(gamesProvider);

      verify(databaseHelper.delete('1')).called(1);
      expect(state, isEmpty);
    });
  });
}
