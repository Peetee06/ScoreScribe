import 'package:flutter/material.dart';
import 'package:spielblock/models/player_score.dart';

class ScoreboardScreen extends StatefulWidget {
  const ScoreboardScreen(this.playerScores, {super.key});

  final List<PlayerScore> playerScores;

  @override
  State<ScoreboardScreen> createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  bool _reversed = false;

  @override
  Widget build(BuildContext context) {
    List<PlayerScore> playerScores = widget.playerScores;

    if (_reversed) {
      playerScores = playerScores.reversed.toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scoreboard",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceTint,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        elevation: 2,
        shadowColor: Theme.of(context).colorScheme.shadow,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Lowest score first",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Switch(
                        value: _reversed,
                        onChanged: (value) {
                          setState(() {
                            _reversed = value;
                          });
                        })
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (playerScores.length > 1)
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      playerScores[1].name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: const EdgeInsets.only(bottom: 8),
                                    height: 100,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 204, 219, 225),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8))),
                                    child: Text(
                                      playerScores[1].score.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "2.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    playerScores[0].name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: const EdgeInsets.only(bottom: 8),
                                  height: 150,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 227, 202, 113),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                  ),
                                  child: Text(
                                    playerScores[0].score.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "1.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          if (playerScores.length > 2)
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      playerScores[2].name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: const EdgeInsets.only(bottom: 8),
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 229, 181, 107),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                    ),
                                    child: Text(
                                      playerScores[2].score.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "3.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8), // Gap between Row and ListView
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SafeArea(
                    child: playerScores.length > 3
                        ? ListView.builder(
                            itemCount: playerScores.length - 3,
                            itemBuilder: (context, index) {
                              index += 3;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 60),
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: ListTile(
                                    dense: true,
                                    shape: const BeveledRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    tileColor: Colors.amber,
                                    leading: Text(
                                      '${index + 1}.',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    title: Text(
                                      playerScores[index].name,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    trailing: Text(
                                      playerScores[index].score.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
