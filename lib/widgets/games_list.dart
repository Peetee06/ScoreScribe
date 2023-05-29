import 'package:flutter/material.dart';
import 'package:spielblock/models/game.dart';
import 'package:spielblock/screens/game.dart';
import 'package:spielblock/widgets/alerts/edit_game_name.dart';
import 'package:spielblock/widgets/animated_arrow.dart';

class GamesList extends StatelessWidget {
  const GamesList(this.games,
      {super.key, required this.onRemoveGame, required this.onUpdateGame});

  final List<Game> games;
  final void Function(Game game) onRemoveGame;
  final void Function(Game game) onUpdateGame;

  @override
  Widget build(BuildContext context) {
    if (games.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'No games yet.\nStart a new one now!',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedArrow(),
            ),
          ],
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
