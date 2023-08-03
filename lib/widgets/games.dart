import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorecard/models/game.dart';
import 'package:scorecard/providers/games_provider.dart';
import 'package:scorecard/widgets/games_list.dart';

class Games extends ConsumerStatefulWidget {
  const Games({super.key});

  @override
  ConsumerState<Games> createState() => _GamesState();
}

class _GamesState extends ConsumerState<Games> {
  late Future<void> _gamesFuture;

  @override
  void initState() {
    super.initState();
    _gamesFuture = ref.read(gamesProvider.notifier).getGames();
  }

  void _removeGame(Game game) {
    ref.read(gamesProvider.notifier).deleteGame(game);
  }

  void updateGame(Game updatedGame) {
    ref.read(gamesProvider.notifier).updateGame(updatedGame);
  }

  @override
  Widget build(BuildContext context) {
    final games = ref.watch(gamesProvider);
    return FutureBuilder(
      future: _gamesFuture,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GamesList(
                  games,
                  onRemoveGame: _removeGame,
                  onUpdateGame: updateGame,
                ),
    );
  }
}
