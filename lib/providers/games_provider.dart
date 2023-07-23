import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:spielblock/models/game.dart';
import 'package:spielblock/utils/database_helper.dart';

class GamesNotifier extends StateNotifier<List<Game>> {
  final DatabaseHelper databaseHelper;

  GamesNotifier({DatabaseHelper? dbHelper})
      : databaseHelper = dbHelper ?? DatabaseHelper.instance,
        super(const []);

  Future<void> getGames() async {
    List<Map<String, dynamic>> gamesData = await databaseHelper.query();
    final games = gamesData
        .map(
          (row) => Game.fromMap(row),
        )
        .toList();
    state = games;
  }

  void addGame(Game game) async {
    databaseHelper.insert(game.toMap());
    state = [game, ...state];
  }

  void updateGame(Game game) async {
    databaseHelper.update(game.toMap());
    state = [
      for (final g in state)
        if (g.id == game.id) game else g,
    ];
  }

  void deleteGame(Game game) async {
    databaseHelper.delete(game.id);
    state = [
      for (final g in state)
        if (g.id != game.id) g,
    ];
  }
}

final gamesProvider = StateNotifierProvider<GamesNotifier, List<Game>>(
  (ref) => GamesNotifier(),
);
