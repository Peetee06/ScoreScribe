import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:spielblock/models/game.dart';
import 'package:spielblock/models/player_score.dart';
import 'package:spielblock/providers/games_provider.dart';
import 'package:spielblock/screens/scoreboard.dart';
import 'package:spielblock/widgets/animated_arrow_right_to_left.dart';

import '../models/round.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key, required this.game});

  final Game game;

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  LinkedScrollControllerGroup? _linkedControllers;
  List<ScrollController> _controllers = [];

  @override
  void initState() {
    _linkedControllers = LinkedScrollControllerGroup();
    _controllers = List.generate(widget.game.playerNames.length,
        (index) => _linkedControllers!.addAndGet());
    super.initState();
  }

  void addRound() {
    final newRound = Round(
      widget.game.playerNames
          .asMap()
          .map((index, playerName) => MapEntry(playerName, 0)),
    );
    setState(() {
      widget.game.rounds.add(newRound);
    });
    ref.read(gamesProvider.notifier).updateGame(widget.game);
  }

  void updatePlayerScore(String playerName, int round, int score) {
    Round roundData = widget.game.rounds[round];
    setState(() {
      roundData.scores[playerName] = score;
    });
    ref.read(gamesProvider.notifier).updateGame(widget.game);
  }

  @override
  Widget build(BuildContext context) {
    final playerNames = widget.game.playerNames;
    final rounds = widget.game.rounds;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game.name,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                )),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: playerNames.length,
                  itemBuilder: (context, index) {
                    String currentPlayer = playerNames[index];
                    int currentRoundScore =
                        rounds[rounds.length - 1].scores[currentPlayer]!;
                    int currentPlayerScore =
                        getPlayerScore(rounds, currentPlayer);
                    final ScrollController scrollController =
                        _controllers[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 28,
                      ),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: double.infinity,
                      height: 116,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 16,
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Center(
                                      child: Text(
                                        currentPlayer,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 10,
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Score',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                            ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        child: Text(
                                          currentPlayerScore.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 48,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer
                                      .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  height: 48,
                                  width: 72,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .shadow
                                            .withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(-4, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (rounds.length == 1 &&
                                  rounds[0]
                                      .scores
                                      .values
                                      .every((element) => element == 0))
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'Tab to add score',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondaryContainer,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 88),
                                        child: SizedBox(
                                            height: 48,
                                            child: AnimatedArrow(
                                              reversed: true,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              if (rounds.length == 1 &&
                                  !rounds[0]
                                      .scores
                                      .values
                                      .every((element) => element == 0))
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: SizedBox(
                                          height: 48,
                                          child: AnimatedArrow(),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 88),
                                        child: Text(
                                          'Swipe to add round',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSecondaryContainer,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 48,
                                      child: CustomRefreshIndicator(
                                        onRefresh: () async {
                                          addRound();
                                        },
                                        builder: MaterialIndicatorDelegate(
                                          builder: (context, controller) {
                                            return Icon(
                                              Icons.add,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                            );
                                          },
                                        ),
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          reverse: true,
                                          controller: scrollController,
                                          itemCount: rounds.length > 5
                                              ? rounds.length - 1
                                              : 5,
                                          itemBuilder: (context, innerIndex) {
                                            if (rounds.length <= 5 &&
                                                innerIndex >=
                                                    rounds.length - 1) {
                                              return const SizedBox(
                                                width: 56,
                                                height: 48,
                                              );
                                            }
                                            final int reversedIndex =
                                                rounds.length - 2 - innerIndex;
                                            Round currentRound =
                                                rounds[reversedIndex];
                                            int playerScore = currentRound
                                                    .scores[currentPlayer] ??
                                                0;
                                            return SizedBox(
                                              width: 56,
                                              child: Center(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${reversedIndex + 1}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .onSecondaryContainer,
                                                        ),
                                                  ),
                                                  Text(
                                                    playerScore.toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .onSecondaryContainer,
                                                        ),
                                                  ),
                                                ],
                                              )),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      String? newScore =
                                          await _showMyDialog(context);
                                      if (newScore != null &&
                                          newScore.isNotEmpty) {
                                        setState(() {
                                          updatePlayerScore(
                                              currentPlayer,
                                              rounds.length - 1,
                                              int.parse(newScore));
                                        });
                                      }
                                    },
                                    child: SizedBox(
                                      width: 72,
                                      height: 48,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Current',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondaryContainer,
                                                  ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Text(
                                                currentRoundScore.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSecondaryContainer,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.only(left: 60, right: 60, bottom: 16),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ScoreboardScreen(
                            getPlayerScoresSorted(widget.game)),
                      ),
                    );
                  },
                  child: Text('Scoreboard',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          )),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

int getPlayerScore(List<Round> rounds, String playerName) {
  int playerScore = 0;
  for (Round round in rounds) {
    playerScore += round.scores[playerName] ?? 0;
  }
  return playerScore;
}

List<PlayerScore> getPlayerScoresSorted(Game game) {
  List<PlayerScore> playerScores = [];
  for (var i = 0; i < game.playerNames.length; i++) {
    String playerName = game.playerNames[i];
    int playerScore = getPlayerScore(game.rounds, playerName);
    playerScores.add(PlayerScore(name: playerName, score: playerScore));
  }
  playerScores.sort((playerScore1, playerScore2) =>
      playerScore2.score.compareTo(playerScore1.score));
  return playerScores;
}

Future<String?> _showMyDialog(BuildContext context) async {
  TextEditingController myController = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Enter the score'),
        content: TextField(
          autofocus: true,
          controller: myController,
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: false),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9]*')),
          ],
          onSubmitted: (value) => Navigator.of(context).pop(value),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              Navigator.of(context).pop(myController.text);
            },
          ),
        ],
      );
    },
  );
}
