import 'package:flutter/material.dart';
import 'package:spielblock/models/game.dart';
import 'package:spielblock/screens/game.dart';
import 'package:spielblock/widgets/edit_game_name.dart';

class GamesList extends StatelessWidget {
  const GamesList(this.games,
      {super.key, required this.onRemoveGame, required this.onUpdateGame});

  final List<Game> games;
  final void Function(Game game) onRemoveGame;
  final void Function(Game game) onUpdateGame;

  @override
  Widget build(BuildContext context) {
    if (games.isEmpty) {
      return Center(
        child: Text(
          'No games yet, start a new one now!',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];

          return Dismissible(
            key: ValueKey(game.id),
            onDismissed: (direction) {
              onRemoveGame(game);
            },
            background: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Container(
                color: Theme.of(context).colorScheme.errorContainer,
                margin: Theme.of(context).cardTheme.margin,
                padding: const EdgeInsets.only(right: 8),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.delete),
                ),
              ),
            ),
            direction: DismissDirection.endToStart,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: Theme.of(context).colorScheme.secondaryContainer,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Text(
                  game.name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    void onNameChanged(String newName) {
                      game.name = newName;
                      onUpdateGame(game);
                    }

                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return EditGameNameAlertDialog(
                            onNameChanged: onNameChanged);
                      },
                    );
                  },
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => GameScreen(game: game),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    }
  }
}
